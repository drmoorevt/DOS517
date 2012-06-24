module ReportsHelper


  class UserStat
    def initialize
      @username = ""
      @totalposts = 0
      @totalcomments = 0
      @last_activity_date = nil
      @userid = 0
      @userobj = nil
    end
  end
end
