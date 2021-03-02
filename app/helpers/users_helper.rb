module UsersHelper
    #渡されたユーザーのgravatar画像を返す
    def gravatar_for(user,options = {size: 80}) #options = {size: 80}
        #if !!user.email
        #    user.email = user.email.downcase
        #end
        
        gravatar_id = Digest::MD5::hexdigest("dwfsvsf3@example.com")
        size = options[:size]
        gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?#{size}"
        image_tag(gravatar_url,alt: "user.name",class: "gravatar")
    end
end
