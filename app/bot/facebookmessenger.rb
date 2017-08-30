require 'facebook/messenger'
require 'json'
require 'uri'
require 'net/http'

include Facebook::Messenger

if ENV["FB_ACCESS_TOKEN"].present?

  # Subscripte to Messenger page
  Facebook::Messenger::Subscriptions.subscribe(access_token: ENV.fetch("FB_ACCESS_TOKEN"))

  # Optin (when user logged in for the frist time to Messenger update)
  Bot.on :optin do |optin|
    optin.sender    # => { 'id' => '1008372609250235' }
    optin.recipient # => { 'id' => '2015573629214912' }
    optin.sent_at   # => 2016-04-22 21:30:36 +0200
    optin.ref       # => 'CONTACT_SKYNET'

    # Initiate conversation with user (first message)
    reply_message = {
        "recipient": {
          "user_ref": optin.messaging["optin"]["user_ref"]
        },
        "message": {
          "text":"Hi there! Welcome to Calypso"
        }
      }

    uri = URI("https://graph.facebook.com/v2.6/me/messages?access_token=#{ENV.fetch("FB_ACCESS_TOKEN")}")
    http = Net::HTTP.new(uri.host, uri.port)
    req = Net::HTTP::Post.new(uri.request_uri, 'Content-Type' => 'application/json')
    req.body = reply_message.to_json
    http.use_ssl = true
    recipient_id_hash = http.request(req)

    # Parse FB callback and save FB recipient ID
    recipient_id = JSON.parse(recipient_id_hash.body)["recipient_id"]

    # Ask FB for correspondong UID (recipient ID != UID)
    uri = URI("https://graph.facebook.com/v2.6/#{recipient_id}/ids_for_apps?app=112177822805280&access_token=#{ENV.fetch("FB_ACCESS_TOKEN")}")
    uid_hash = Net::HTTP.get(uri)

    # Parse FB callback and save corresponding UID
    uid = JSON.parse(uid_hash)["data"][0]["id"]

    # Update user with mathcing recipient ID (used for all conversations after optin)
    user_updated = User.where(uid: uid).first
    user_updated.recipient_id = recipient_id
    user_updated.save

    # Notify user that he has signed in for alerts covering the chosen city
    Bot.deliver({
      recipient: {
        id: 1458086380949769
      },
      message: {
        text: "I will send you notifications when trips departing from #{user_updated.follow_city} are created 😄‍"
      }
    }, access_token: ENV['FB_ACCESS_TOKEN'])
  end

  # Manage "out of the blue" incoming messages
  Bot.on :message do |message|
    message.reply(text: 'Sorry, I am busy looking for trips you might be interested in 😎')
  end

  # Manage callback triggered by "send request" button
  Bot.on :postback do |postback|
    postback_content = JSON.parse(postback.payload)

    trip_id = postback_content["trip_id"]
    user_id = postback_content["user_id"]

    new_participant = Participant.new
    new_participant.trip = Trip.find(trip_id)
    new_participant.user = User.find(user_id)
    new_participant.status = "pending"
    new_participant.message = "Request sent over Facebook messenger"
    new_participant.save

    postback.reply(text: "Request sent ! Go to Calypso.surf to check your booking status ;)")
  end
end

