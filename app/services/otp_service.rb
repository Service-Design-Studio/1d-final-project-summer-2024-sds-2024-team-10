class OtpService
  ACCOUNT_SID = 'AC56da4be39f369635cf7b77bed6a94d9c'
  AUTH_TOKEN = '302fd0f0a589b9aab294107ab69d5861'

  attr_reader :otp, :phone_number

  def initialize(phone_number)
    @phone_number = format_phone_number(phone_number)
    @otp = ROTP::TOTP.new("base32secret3232").now
  end

  def send_otp
    @client = Twilio::REST::Client.new(ACCOUNT_SID, AUTH_TOKEN)
    
    verification = @client.verify
                     .v2
                     .services('VA24a08c55be3e1ea1a87aeef16fcff83b')
                     .verifications
                     .create(to: @phone_number, channel: 'sms')
    
    puts verification.sid
  end

  def verify_otp(otp_code)
    @client = Twilio::REST::Client.new(ACCOUNT_SID, AUTH_TOKEN)

    verification_check = @client.verify
                               .v2
                               .services('VA24a08c55be3e1ea1a87aeef16fcff83b')
                               .verification_checks
                               .create(to: @phone_number, code: otp_code)

    verification_check.status == 'approved'
  end

  private

  def format_phone_number(phone_number)
    # Assuming the phone number is a Singapore number and adding the country code
    "+65#{phone_number}"
  end
end
