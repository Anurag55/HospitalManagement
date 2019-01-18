class SessionsController < ApplicationController


  def new
    check_user_logged_in
  end

  def create

    @user=User.find(:first, :conditions => {:username => params[:username], :password => params[:password] } )
    if @user.nil?
      redirect_to new_user_path
    elsif @user.confirmed=='0'
       flash[:notice] = "User not confirmed yet"
       redirect_to :action => "new"
    else
      session[:current_user_id] = @user.id
      check_user_logged_in
    end
  end

  def logout
    session[:current_user_id] = nil
    redirect_to  :controller => "sessions", :action => "new"
  end

  def confirmation
    @user=User.first(:conditions => {:confirmation_token => params[:token] } )
    if @user.nil?
      flash[:notice] = "Confirmation token not exist"
      redirect_to :action => "new"
    else
      @user.update_attributes(:confirmed => '1', :confirmation_token => nil)
      flash[:notice] = "User confirmed successfully"
      redirect_to :action => "new"
    end
  end

  def forgot_password_form
    if current_user.nil?
      render :action => "forgot_password_form"
    else
      redirect_to :action => "index"
    end
  end

  def reset_password_confirmation
    @user=User.first(:conditions => {:email => params[:email] } )
    if @user.nil?
      flash[:notice] = "No such user exists"
      redirect_to :action => "forgot_password_form"
    else
      @user.update_attributes(:reset_token => SecureRandom.hex(10))
      UserMailer.deliver_reset_email(@user)
      redirect_to :action => "new"
    end
  end

  def reset_password_form
      @user=User.first(:conditions => {:reset_token => params[:token] } )

      if @user.nil?
        flash[:notice] = "Token expired"
        redirect_to :action => "new"
      else
        render :action => "reset_password_form"
      end

  end

  def reset_password

      @user=User.first(:conditions => {:reset_token => params[:id] } )
      if @user.update_attributes(:password => params[:password], :reset_token => nil)
        redirect_to :action => "new"
      else
        redirect_to :action => "new"
      end
  end

  def change_password_form
    if current_user.present?
      render :action => "change_password_form"
    else
      redirect_to  :action => "new"
    end
  end

  def change_password
    current_user.password= params[:password]
    if current_user.save
      flash[:notice] = "Password changed Successfully..."
      redirect_to  :action => "new"
    else
      flash[:notice] = "Password couldnt be changed,Try again..."
      redirect_to :action => "change_password_form"
    end
  end

end
