class SqlTemplatesController < ApplicationController
  append_view_path SqlTemplate::Resolver.instance

  # GET /sql_templates
  # GET /sql_templates.json
  def index
    @sql_templates = SqlTemplate.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @sql_templates }
    end
  end

  # GET /sql_templates/1
  # GET /sql_templates/1.json
  def show
    @sql_template = SqlTemplate.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @sql_template }
    end
  end

  # GET /sql_templates/new
  # GET /sql_templates/new.json
  def new
    @sql_template = SqlTemplate.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @sql_template }
    end
  end

  # GET /sql_templates/1/edit
  def edit
    @sql_template = SqlTemplate.find(params[:id])
  end

  # POST /sql_templates
  # POST /sql_templates.json
  def create
    @sql_template = SqlTemplate.new(params[:sql_template])

    respond_to do |format|
      if @sql_template.save
        format.html { redirect_to @sql_template, notice: 'Sql template was successfully created.' }
        format.json { render json: @sql_template, status: :created, location: @sql_template }
      else
        format.html { render action: "new" }
        format.json { render json: @sql_template.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /sql_templates/1
  # PUT /sql_templates/1.json
  def update
    @sql_template = SqlTemplate.find(params[:id])

    respond_to do |format|
      if @sql_template.update_attributes(params[:sql_template])
        format.html { redirect_to @sql_template, notice: 'Sql template was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @sql_template.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sql_templates/1
  # DELETE /sql_templates/1.json
  def destroy
    @sql_template = SqlTemplate.find(params[:id])
    @sql_template.destroy

    respond_to do |format|
      format.html { redirect_to sql_templates_url }
      format.json { head :no_content }
    end
  end
end
