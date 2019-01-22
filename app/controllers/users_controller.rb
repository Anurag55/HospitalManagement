class UsersController < ApplicationController
  filter_access_to :all

  def index
  end

  def new
      @user = User.new
  end

  def create
      @user = User.new(params[:user])
      @user.password = "#{params[:user][:username]}123"
      if params[:user][:is_doctor] == "1"
        @user.profile_type= "Doctor"
        if @user.save
          flash[:message] = "Created doctor successfully"
          redirect_to admins_path
        else
          render :new
        end
      else
        @user.profile_type= "Patient"
        if @user.save
          flash[:message] = "Created user successfully"
          redirect_to :controller => "sessions", :action => "new"
        else
          render :new
        end
      end
  end

  def edit
    @user=User.find(params[:id])
  end

  def update
    @user=User.find(params[:id])
    if @user.update_attributes(params[:user])
      flash[:notice] = "Profile image updated"
    else
      flash[:message] = "Profile image cant update, Try again..."
    end
    redirect_to :controller => "sessions", :action => "new"
  end
end
