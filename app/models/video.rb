class Video < ActiveRecord::Base

	before_create -> do
	  uid = link.match(YT_LINK_FORMAT)
	  self.uid = uid[2] if uid && uid[2]

	  if self.uid.to_s.length != 11
	    self.errors.add(:link, 'is invalid.')
	    false
	  elsif Video.where(uid: self.uid).any?
	    self.errors.add(:link, 'is not unique.')
	    false
	  else
	    get_additional_info
	  end
	end


end
