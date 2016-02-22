class WikiPolicy < ApplicationPolicy

  def index?
    false
  end

  def show?
    record.public? || user.present?
  end

  def create?
    show?
  end

  def new?
    show?
  end

  def update?
    show?
  end

  def edit?
    show?
  end

  def destroy?
    user.admin? or user.premium?
  end

  class Scope
    attr_reader :user, :scope # :wiki,

    def initialize(user, scope) # wiki,
      @user = user
      # @wiki = wiki
      @scope = scope
    end

    def resolve
       wikis = []
       if user.role == 'admin'
         wikis = scope.all
       elsif user.role == 'premium'
         all_wikis = scope.all
         all_wikis.each do |wiki|
           if wiki || wiki.user == user || wiki.collaborated_users.include?(user)
             wikis << wiki
           end
         end
       else
         all_wikis = scope.all
         all_wikis.each do |wiki|
           if wiki.public? || wiki.collaborated_users.include?(user)
             wikis << wiki
           end
         end
       end
       wikis
     end
   end
 end
