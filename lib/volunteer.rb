class Volunteer
  attr_reader :id
  attr_accessor :name, :project_id

  def initialize(attributes)
    @name = attributes.fetch(:name)
    @project_id= attributes.fetch(:project_id)
    @id = attributes.fetch(:id)
  end

  def ==(other_volunteer)
    if other_volunteer != nil
      (self.name() == other_volunteer.name()) && (self.project_id() == other_volunteer.project_id())
    else
      false
    end
  end

end