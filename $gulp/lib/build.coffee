cfg = require '../config'
_ = require 'lodash'
glob = require 'globby'

class Build # another type of cache. PS: mb rename to Cache?
    @getByGlob: (mask, cwd = cfg.path.build) =>
        if !_.isArray mask then mask = [mask]
        res = glob.sync mask, {cwd, nosort: true}
        res = _.uniq res
        res.map (v) -> '/' + v

    @getScripts: =>
        @getByGlob '**/*.js'

    @getStyles: =>
        @getByGlob '**/*.css'

    @getTemplates: =>
        @getByGlob '**/*.html'

    @getNgScripts: =>
        @getByGlob ['**/*.module.js', '**/*.js']

module.exports = Build
