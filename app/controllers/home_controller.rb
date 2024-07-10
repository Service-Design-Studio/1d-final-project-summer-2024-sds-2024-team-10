class HomeController < ApplicationController
    def index
      @message = "SDS Team 10: DBS_DocCheck"
    end
  
    def about
      render '../about'
    end
  
    def contact
    end
  end
  