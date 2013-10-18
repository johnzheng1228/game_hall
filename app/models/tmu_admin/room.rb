module TmuAdmin
  class Room < ActiveRecord::Base
    def summary
      {
          :id => id,
          :name => name,
          :backgroud => backgroud||"",
          :total => total_lest,
          :single => single_lest
      }
    end
  end
end
