class GroupsController < ApplicationController

  before_action :require_sign_in, except: [:index, :show]
  before_action :authorize_user, except: [:index, :show]

  def index
    @groups = Group.all
  end

  def show
    @group = Group.find(params[:id])
  end

  def new
    @group = Group.new
  end

  def create
    @group = Group.new(group_params)

    if @group.save
      redirect_to @group
      flash[:notice] = "Group was successfully saved"
    else
      flash.now[:alert] = "Error trying to create this Group. Please Try Again"
      render :new
    end
  end

  def edit
    @group = Group.find(params[:id])
  end

  def update
    @group = Group.find(params[:id])

    @group.assign_attributes(group_params)

    if @group.save
      flash[:notice] = "Group was updated"
      redirect_to @group
    else
      flash.now[:alert] = "Error saving group. Please try again."
      render :edit
    end
  end

  def destroy
    @group = Group.find(params[:id])

    if @group.destroy
      flash[:notice] = "#{@group.name} was deleted successfully"
      redirect_to action: :index
    else
      flash.now[:alert] = "There was an error trying to delete this group."
      render :show
    end
  end

  private

  def group_params
    params.require(:group).permit(:name, :description, :public)
  end

  def authorize_user
    unless current_user.admin?
      flash[:alert] = "You must be an admin to do that."
      redirect_to groups_path
    end
  end

end
