Factory.define :team do |f|
  f.sequence(:name) {|i| "Team Name #{i}"}
end