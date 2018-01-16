require 'rubygems'
require 'sinatra'
require 'line/bot'
require 'firebase'

def client
  @client ||= Line::Bot::Client.new { |config|
    config.channel_secret = ENV['LINE_CHANNEL_SECRET']
    config.channel_token = ENV['LINE_CHANNEL_TOKEN']
  }
end


post '/webhooks' do
  body = request.body.read

  signature = request.env['HTTP_X_LINE_SIGNATURE']
  
  unless client.validate_signature(body, signature)
    error 400 do 'Bad Request' end
  end

  events = client.parse_events_from(body)
  events.each { |event|
    case event
    when Line::Bot::Event::Message
      case event.type
      when Line::Bot::Event::MessageType::Text
        client.reply_message(event['replyToken'], filter_message(event.message['text']))
      when Line::Bot::Event::MessageType::Image, Line::Bot::Event::MessageType::Video
        response = client.get_message_content(event.message['id'])
        tf = Tempfile.open("content")
        tf.write(response.body)
      end
    end
  }

  "OK"
end


def res_menu
  "Check North limit, press(001) \n\n" + 
  "Check South limit, press(002) " 
end

def get_server_res sid

  firebase = Firebase::Client.new(ENV['FIREBASE_DB_URL'], ENV['FIREBASE_AUTH_TOKEN'])
  res = firebase.get('server' + sid + '/limit')

  if res.success? && res.body
    "Online connect: " + res.body.to_s
  else
    "error response!! \nplease retry agin."
  end

end


def filter_message text
  case text
  when '001'
    message = {
      type: 'text',
      text: get_server_res(text)
    }
  when '002'
    message = {
      type: 'text',
      text: get_server_res(text)
    }
  else
    message = {
      type: 'text',
      text: res_menu
    }
  end
end

