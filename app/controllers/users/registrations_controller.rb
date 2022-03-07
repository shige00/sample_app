class Users::RegistrationsController < Devise::RegistrationsController
    def new
        super
    end

    def create
        super
    end

    def destroy
        if current_user == resource && current_user.admin?
            flash[:notice] = "管理者のため削除できません"
            redirect_to user_path(resource)
        else
            super
        end
    end

    def edit
        super
    end
    
    def cancel
        super
    end

    def update
        super
    end
end