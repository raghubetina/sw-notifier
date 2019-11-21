class FlightsController < ApplicationController
  def index
    @upcoming_flights = @current_user.flights.where("departs_at >= ?", DateTime.now).order({ :departs_at => :asc })

    @past_flights = @current_user.flights.where("departs_at < ?", DateTime.now).order({ :departs_at => :desc })

    render({ :template => "flights/index.html.erb" })
  end

  def show
    the_id = params.fetch("id_from_path")
    @flight = Flight.where({:id => the_id }).at(0)

    render({ :template => "flights/show.html.erb" })
  end

  def create
    @flight = Flight.new
    @flight.departs_at = params.fetch("departs_at_from_query")
    @flight.user_id = session.fetch(:user_id)
    @flight.description = params.fetch("description_from_query")

    if @flight.valid?
      @flight.save
      redirect_to("/flights", { :notice => "Flight created successfully."})
    else
      redirect_to("/flights", { :notice => "Flight failed to create successfully."})
    end
  end

  def update
    the_id = params.fetch("id_from_path")
    @flight = Flight.where(:id => the_id).at(0)

    @flight.departs_at = params.fetch("departs_at_from_query")
    @flight.user_id = params.fetch("user_id_from_query")
    @flight.description = params.fetch("description_from_query")

    if @flight.valid?
      @flight.save
      redirect_to("/flights/#{@flight.id}", {:notice => "Flight updated successfully."})
    else
      render({ :template => "flights/show.html.erb" })
    end
  end

  def destroy
    the_id = params.fetch("id_from_path")
    @flight = Flight.where({ :id => the_id }).at(0)

    @flight.destroy

    redirect_to("/flights", {:notice => "Flight deleted successfully."})
  end
end
