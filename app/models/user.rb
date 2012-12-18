class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
   PROFILE_CREATED_BY = ["self", 1],["perants", 2],["friend", 3] 
   RELIGION = ["Hindu", 1],["Muslim", 2],["Sikkh", 3],["Cristian", 4]
   AGE = [18, 18], [19, 19], [20, 20], [21, 21], [22, 22], [23, 23], [24, 24], [25, 25], [26, 26], [27, 27], 
         [28, 28], [29, 29], [30, 30], [31, 31], [32, 32], [33, 33], [34, 34], [35, 35], [36, 36], [37, 37],
         [38, 38], [39, 39], [40, 40], [41, 41], [42, 42], [43, 43], [44, 44], [45, 45], [46, 46], [47, 47],
         [48, 48], [49, 49], [50, 50], [51, 51], [52, 52], [53, 53], [54, 54], [55, 55], [56, 56], [57, 57],
         [58, 58], [59, 59], [60, 60], [61, 61], [62, 62], [63, 63], [64, 64], [65, 65], [66, 66], [67, 67],
         [68, 68], [69, 69], [70, 70], [71, 71], [72, 72], [73, 73], [74, 74], [75, 75], [76, 76], [77, 77],
         [78, 78], [79, 79], [80, 80], [81, 81], [82, 82], [83, 83], [84, 84], [85, 85], [86, 86], [87, 87],
         [88, 88], [89, 89], [90, 90]

   HEIGHT = ["3 ft 5 ench", 102], ["3 ft 6 ench", 105], ["3 ft 7 ench", 109], ["3 ft 8 ench", 112], ["3 ft 9 ench", 115],
     ["3 ft 10 ench", 118], ["3 ft 11 ench", 121], ["4 ft 0 ench", 124], ["4 ft 1 ench", 127], ["4 ft 2 ench", 130], 
         ["4 ft 2 ench", 133], ["4 ft 3 ench", 136], ["4 ft 4 ench", 139], ["4 ft 5 ench", 142], ["4 ft 6 ench", 145],
         ["4 ft 7 ench", 148], ["4 ft 8 ench", 151], ["4 ft 9 ench", 154], ["4 ft 11 ench", 157], ["4 ft 12 ench", 160],
         ["5 ft 0 ench", 163], ["5 ft 1 ench", 166], ["5 ft 2 ench", 169], ["5 ft 3 ench", 172], ["5 ft 6 ench", 175],
         ["5 ft 7 ench", 178], ["5 ft 6 ench", 181], ["5 ft 7 ench", 184], ["5 ft 8 ench", 187], ["5 ft 9 ench", 190],
         ["5 ft 10 ench", 193], ["5 ft 11 ench", 196], ["5 ft 12 ench", 199], ["6 ft 1 ench", 201], ["6 ft 2 ench", 204],
         ["6 ft 3 ench", 208], ["6 ft 4 ench", 211], ["6 ft 5 ench", 214]    

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable, :omniauthable

  serialize :user_info, ActiveRecord::Coders::Hstore
  
  #attache file and validate  
  attr_accessible :avatar
  has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100>" } 
  
  attr_accessor :name, :cast, :religion, :age, :occupation, :organization, :about_us,
                :parmanent_address, :physical_status, :eating_habbit, :family, :marrital_status,:Height, 
                :weight, :horoscope, :income, :current_address, :profile_created_by

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :remember_me, :user_info

  attr_accessible :provider, :uid, :password

  # attr_accessible :title, :body
  attr_accessible :name, :cast, :religion, :age, :occupation, :age, :organization, :about_us, :parmanent_address, :physical_status, 
                  :eating_habbit, :family, :marrital_status, :weight, :horoscope, :income, :current_address, :profile_created_by,
                  :Height  

  def self.find_for_facebook_oauth(auth, signed_in_resource=nil)
    user = User.where(:provider => auth.provider, :uid => auth.uid).first
    unless user
      user = User.new(name:auth.extra.raw_info.name,
                           provider:auth.provider,
                           uid:auth.uid,
                           email:auth.info.email
                           )
      user.skip_confirmation!
      user.save!
    end
    user
  end
end
