requireAll = (requireContext) ->
    modules = requireContext.keys()
    modules = _(modules)
        .map (v) ->
            if ~v.indexOf '/__' then return # exclude prefix
            requireContext v
        .value()

requireAll require.context './', true, /\.coffee$/ # auto require from project
