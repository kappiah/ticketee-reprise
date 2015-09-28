class Admin::StatesController < Admin::ApplicationController

  def index
    @states = State.all
  end

  def new
    @state = State.new
  end

  def create
    @state = State.new(state_params)

    if @state.save
      flash[:notice] = "State has been created"
      redirect_to admin_states_path
    else
      flash.now[:error] = "State has now been created"
      render :new
    end
  end

  def make_default
    @state = State.find(params[:id])
    @state.make_default!
    flash[:notice] = "'#{@state.name}' is the new default state"
    redirect_to admin_states_path
  end

  private
  def state_params
    params.require(:state).permit(:name, :colour)
  end
end
