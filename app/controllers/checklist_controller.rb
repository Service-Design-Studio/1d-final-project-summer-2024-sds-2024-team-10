class ChecklistController < ApplicationController
  def checklist
    @checklist_items = { 
    passport: ['Proof of Identity',{'Identity Card (For Malaysians)' => "malaysiaic.jpg",'Passport (For other Nationalities)' => 'passport.jpg'}], 
    employment: ['Proof of Employment',{'Employment Letter' => "employment.jpg",'Student Pass' => "studentpass.jpg",'Dependent/Long Term Visit Pass' => "dependantpass.jpg"}], 
    address: ['Proof of Residential Address',{'Singapore utility/telecommunication bill' => "address.jpg",'Certification letter of employment' => "employmentaddress.jpg",'Certification letter from school' => "educationaddress.png"}], 
    tax: ['Proof of Tax Residency',{'Passport' => "passport.jpg",'National Identity Card' => "malaysiaic.jpg",'Student Pass' => "studentpass.jpg"}], 
    mobile: ['Proof of Mobile Ownership',{'Telco Bill' => "mobile.jpg",'Telco Confirmation Letter' => "telcoconfirm.jpg"}] 
  }
  end

  def next
    redirect_to '/general_info'
  end
end
