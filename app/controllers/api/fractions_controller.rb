class Api::FractionsController < ApplicationController
  before_action :must_be_signed_in, except: [:show, :index]
  before_action :must_have_current_character, except: [:show, :index]
  before_action :find_or_initialize_fraction, except: [:create, :index]

  def index
    @fractions = Fraction.roots
  end

  def create
    @founder = params[:fraction][:founder_type].constantize.find(params[:fraction][:founder_id])

    if @founder.is_a? Fraction
      unless @founder.authorizes? current_character, :execute, :fraction_create
        render json: "#{ @founder.name } does not authorize #{ current_character.name } to create child fractions on its behalf", status: 422
        return
      end
    elsif @founder.is_a? Character
      unless @founder.id == current_character.id
        render json: "#{ current_character.name } cannot found a fraction on behalf of #{ @founder.name }", status: 422
        return
      end
      unless @founder.can_found_fraction?
        render json: "#{ @founder.name } cannot found a fraction", status: 422
        return
      end
    else
      render json: "Invalid founder type", status: 422
      return
    end

    @fraction = @founder.founded_fractions.new(fraction_params);
    # TODO complex fraction initialization, including authorizations
    if params[:fraction][:make_child]
      unless @founder.authorizes? current_character, :execute, :child_connect
        render json: "#{ @founder.name } does not authorize #{ current_character.name } to connect child fractions", status: 422
        return
      end
      @fraction.assign_attributes parent: @founder
    end

    if @fraction.save
      render :show
    else
      render json: @fraction.errors.full_messages, status: 422
    end
  end

  def show
  end

  private

    def fraction_params
      params.require(:fraction).permit(:name)
    end

    def find_or_initialize_fraction
      @fraction = params[:id] ? Fraction.find(params[:id]) : Fraction.new
    end
end
