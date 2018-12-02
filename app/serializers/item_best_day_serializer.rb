class ItemBestDaySerializer
  include FastJsonapi::ObjectSerializer  
  attributes :date, :sales
end
