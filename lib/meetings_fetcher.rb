require 'google/api_client'
require 'google/api_client/client_secrets'
require 'google/api_client/auth/installed_app'

#TODO: Request id and secret from a different account
SCOPE = ['https://www.googleapis.com/auth/calendar']

class MeetingsFetcher

  def initialize()
    @client = Google::APIClient.new(
      application_name: 'PivotalMeetingRooms',
      application_version: '1.0.0'
    )


    @client.authorization.client_id=ENV['GOOGLE_CLIENT_ID']
    @client.authorization.client_secret=ENV['GOOGLE_CLIENT_SECRET']
    @client.authorization.refresh_token=ENV['GOOGLE_REFRESH_TOKEN']

    @calendar = @client.discovered_api('calendar', 'v3')
  end

  def get_new_refresh_token
    @client.authorization = begin
      installed_app_flow = ::Google::APIClient::InstalledAppFlow.new(
        client_id:     CLIENT_ID,
        client_secret: CLIENT_SECRET,
        scope:         SCOPE
      )
      installed_app_flow.authorize()
    end
  end

  def get_room_events(calendar_id)
    response = @client.execute({
      api_method: @calendar.events.list,
      parameters: {
        calendarId: calendar_id,
        timeMax: (Time.now + (60*60*24)).utc.iso8601,
        timeMin: Time.now.utc.iso8601,
        singleEvents: true,
        orderBy: "startTime"
      },
      headers: {'Content-Type' => 'application/json'}
    })

    organize_events(JSON.parse(response.body))
  end

  def organize_events(events)
    array = []
    events['items'].each do |event|
      next unless event['status'] == 'confirmed'
      temp = {
        title: event['visibility']=='private' ? 'Private' : event['summary'],
        location: event['location'].nil? ? '' : event['location'],
        organizer: event['organizer'].nil? ? 'Anonymous' : event['organizer']['displayName'],
        organizer_email: event['organizer'].nil? ? '' : event['organizer']['email'],
        start: Time.parse(event['start']['dateTime']).to_i,
        end: Time.parse(event['end']['dateTime']).to_i,
        time: Time.parse(event['start']['dateTime']).in_time_zone("Eastern Time (US & Canada)").strftime("%b %d, %I:%M %p")+" - "+Time.parse(event['end']['dateTime']).in_time_zone("Eastern Time (US & Canada)").strftime("%I:%M %p"),
        link: event['htmlLink'].nil? ? '#' : event['htmlLink']
      }

      array.push(temp) if (temp[:end] >= Time.now.to_i)
    end

    array.sort_by { |hash| hash[:start] }
  end

  def get_room_status(events)
    green =  { text: 'Available - Room is not Booked', style: 'green' }
    yellow = { text: 'Reserved - A Meeting will Start Soon', style: 'yellow' }
    red =    { text: 'In Use - Room is Booked', style: 'red' }

    status = green
    current_time = Time.now.to_i
    warning_time = 5*60
    events.each do |item|
      if (item[:start]-current_time) <= warning_time && (item[:start]-current_time) > 0
        status = yellow
      end
      if (item[:start]..item[:end]).include?(current_time)
        status = red
        break
      end
    end

    status
  end

  def refresh_access_token
    @client.authorization.fetch_access_token!
  end

  def get_summarized_events(calendar_id)
    events = get_room_events(calendar_id)
    { items: events, status: get_room_status(events) }
  end
end
