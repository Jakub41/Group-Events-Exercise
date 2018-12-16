json.group_events do
  json.array! @group_events, partial: 'group_event', as: :group_event
end
