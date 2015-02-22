require "sinatra"
require "sinatra/activerecord"
require "./environments"
require "geocoder"
require "twilio-ruby"
require "./models/care_center.rb"
require "./models/response.rb"
require "./env" if File.exists?('env.rb')

$twilio_client = Twilio::REST::Client.new ENV["TWILIO_SID"], ENV["TWILIO_AUTH_TOKEN"]
NO_ADDRESS_FOUND = "We're sorry, we didn't recognize that as a Somerville address."
WELCOME = "Hello! Text me an address in Somerville and I'll send you nearby early child care locations. Example: '93 Highland Ave'"

post '/finder' do

  session["step"] ||= "hello"
  
  if params["Body"].present? && params["From"].present?

    message_body  = params["Body"]
    from_phone    = params["From"]

    if message_body.downcase == "hello"
      session["step"] = "hello"
    end

    case session["step"]
    when "hello"
      Response.new.send_text(from_phone, WELCOME)
      session["step"] = "address"
    when "address"
      @sms_response = Response.new
      @results      = @sms_response.address_results(message_body)

      if @results.present?
        @list     = @results["list"]
        @details  = @results["details"]
        session["details"] = @details
        if @sms_response.send_text(from_phone, @list)
          session["step"] = "results-sent"
        end
      else 
        @sms_response.send_text(from_phone, NO_ADDRESS_FOUND)
      end
    when "results-sent", "detail-sent"
      requested_detail = message_body.to_i
      @detail = session["details"][requested_detail]
      if @detail.present?
        @sms_response = Response.new
        if @sms_response.send_text(from_phone, @detail)
          session["step"] = "detail-sent"
        end
      end
    end
  end
end