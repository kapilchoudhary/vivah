class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
   PROFILE_CREATED_BY = ["self","perants","friend"] 
   EATING_HABBIT = ["vegitarian","non-vagitarian","aggitarian"]

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable, :omniauthable

  serialize :user_info, ActiveRecord::Coders::Hstore


  attr_accessor :name, :cast, :religion, :age, :occupation, :organization, :about_us,
                :parmanent_address, :physical_status, :eating_habbit, :family, :marrital_status, 
                :weight, :horoscope, :income, :current_address, :profile_created_by
  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :remember_me, :user_info
  # attr_accessible :title, :body
  attr_accessible :name, :cast, :religion, :age, :occupation, :age, :organization, :about_us, :parmanent_address, :physical_status, 
                  :eating_habbit, :family, :marrital_status, :weight, :horoscope, :income, :current_address, :profile_created_by

  attr_accessible :provider, :uid

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
