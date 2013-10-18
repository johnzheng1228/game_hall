class Player < ActiveRecord::Base
	include Playerable
	validates_uniqueness_of :name


	has_one :wealth
	attr_accessor :temp_password
	BASE_ID = 10000
	def init_base_info
		self.name = BASE_ID + self.id
		self.temp_password = generate_password
		self.password = sha1
		self.nick_name = "self#{self.id}"
		self.token = generate_token
		self.save
	end

	def json_format
		{
			:id => id,
			:name => name,
			:pwd => temp_password,
			:nickname => nick_name,
			:token => token
		}
	end

	def summary
		{
			:id => id,
			:name => name,
			:nickname => nick_name,
			:gender => rand(2),
			:avatar => "",
			:diamond => 0,
			:gold => 40000
		}
	end


	def regist_result
		{
			:id => id || 0,
			:token => token || ""
		}
	end

	private

	def generate_password
		password_array = %w"0 1 2 3 4 5 6 7 8 9 a b c d e f g h i j k l m n o p q r s t w v u x y z"
		password = password_array.sample(6).join
	end

	def sha1
		Digest::SHA1.hexdigest(temp_password + serial_number)
	end

	def  generate_token
		Digest::SHA1.hexdigest(serial_number + Time.now.strftime("%Y%m%d"))
	end
end
