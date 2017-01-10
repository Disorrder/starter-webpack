export function requireAll(requireContext) {  // auto require from project
    if (!requireContext) requireContext = require.context('./', true, /\.js$/)
    let exclude = ['/__'];
    let modules = requireContext.keys();

    modules = _(modules)
        .filter((v) => {
            console.log('filter', v, !_.some(exclude, (x) => ~v.indexOf(x)));
            return !_.some(exclude, (x) => ~v.indexOf('/__'));
        })
        .map((v) => requireContext(v))
        .value()
    ;
}
