class OtpService
  # Moulik
  # ACCOUNT_SID = 'AC110fb22facbd03185bad17fbec1ca367'
  # AUTH_TOKEN = 'b9ae2d7eb5c7c9c9e4db0ab3ab2768de'
  # SERVICE_SID = 'VA2ffb34d016bf56de2c93a054a17410f6'

  #Genee
  #ACCOUNT_SID = 'ACed085f22fdfebe937d7cd5d5dc3b5a59'
  #AUTH_TOKEN = 'fc5daf42242c552e0d3f262de6f5c4bb'
  #SERVICE_SID = 'VA3f754ed3ff1cb0a1a7daeab5bda2cbd8'

  #Sahitya
  #ACCOUNT_SID = 'AC7dceef9ae05b09e56cba20df269c2137'
  #AUTH_TOKEN = '771079e7f426d60d7f706224306388fe'
  #SERVICE_SID = 'VA820364bd514880809acb4257c8471029'

  #Wanwei
  # ACCOUNT_SID = 'ACaff98bf7072fb0c34a136ea4031c47a9'
  # AUTH_TOKEN = 'd32f2329c3c7a9b6f76cddaea8822b9d'
  # SERVICE_SID = 'VAa64470481352aefd5d0f036737ca76b3'

  #Ernest
  ACCOUNT_SID = 'AC8176d075d6042f75a38abe76dd1a0a26'
  AUTH_TOKEN = '92f6649022e1415d75e6711b7c29ed09'
  SERVICE_SID = 'VA362f7f28675157f96cfe43c6942f8798'

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
