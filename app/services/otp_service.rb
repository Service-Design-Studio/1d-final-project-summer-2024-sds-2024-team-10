class OtpService
  # Moulik
  ACCOUNT_SID = 'AC110fb22facbd03185bad17fbec1ca367'
  AUTH_TOKEN = 'b9ae2d7eb5c7c9c9e4db0ab3ab2768de'
  SERVICE_SID = 'VA2ffb34d016bf56de2c93a054a17410f6'

  # Genee
  ACCOUNT_SID = 'ACed085f22fdfebe937d7cd5d5dc3b5a59'
  AUTH_TOKEN = 'fc5daf42242c552e0d3f262de6f5c4bb'
  SERVICE_SID = 'VA3f754ed3ff1cb0a1a7daeab5bda2cbd8'

  attr_reader :otp, :phone_number

  def initialize(phone_number)
    @phone_number = format_phone_number(phone_number)
    @otp = ROTP::TOTP.new("base32secret3232").now
  end

  def send_otp
    @client = Twilio::REST::Client.new(ACCOUNT_SID, AUTH_TOKEN)
    
    verification = @client.verify
                     .v2
                     .services(SERVICE_SID)
                     .verifications
                     .create(to: @phone_number, channel: 'sms')
    
    puts verification.sid
  end

  def verify_otp(otp_code)
    if otp_code.length != 6
      return false
    end
    @client = Twilio::REST::Client.new(ACCOUNT_SID, AUTH_TOKEN)

    verification_check = @client.verify
                               .v2
                               .services(SERVICE_SID)
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
