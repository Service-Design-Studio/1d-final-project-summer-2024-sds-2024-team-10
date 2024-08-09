class OtpService
  #Ernest
  # ACCOUNT_SID = ENTER YOUR ID HERE
  # AUTH_TOKEN = ENTER TOKEN HERE
  # SERVICE_SID = ENTER ID HERE

  attr_reader :otp, :phone_number

  def initialize(phone_number)
    @phone_number = format_phone_number(phone_number)
    @otp = ROTP::TOTP.new("base32secret3232").now
  end

  def send_otp
    begin
      @client = Twilio::REST::Client.new(ACCOUNT_SID, AUTH_TOKEN)

      verification = @client.verify
                           .v2
                           .services(SERVICE_SID)
                           .verifications
                           .create(to: @phone_number, channel: 'sms')

      puts verification.sid
      return true
    rescue StandardError => e
      @error_message = e.message
      return false
    end
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

  def error_message
    @error_message
  end

  private

  def format_phone_number(phone_number)
    # Assuming the phone number is a Singapore number and adding the country code
    "+65#{phone_number}"
  end
end
