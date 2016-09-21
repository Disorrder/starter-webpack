cfg = require '../config'
_ = require 'lodash'
glob = require 'glob'

class Build # another type of cache. PS: mb rename to Cache?
    @getByGlob: (mask) =>
        res = []
        if not _.isArray mask then mask = [mask]
        mask.forEach (v) ->
            res = res.concat glob.sync v, {cwd: cfg.path.build, nosort: true}
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
