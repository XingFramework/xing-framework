require 'compass/import-once/activate'
# Require any additional compass plugins here.

# Set this to the root of your project when deployed:
http_path = "/"
css_dir = "build/stylesheets"
sass_dir = "src/styles/"
images_dir = "images"
javascripts_dir = "javascripts"
sourcemap = true

add_import_path "src/styles/"
add_import_path "node_modules"
add_import_path "bower_components"

Encoding.default_external = 'utf-8'

# You can select your preferred output style here (can be overridden via the
# command line):
# output_style = :expanded or :nested or :compact or :compressed

# To enable relative paths to assets via compass helper functions. Uncomment:
# relative_assets = true

# To disable debugging comments that display the original location of your selectors. Uncomment:
# line_comments = false


# If you prefer the indented syntax, you might want to regenerate this
# project again passing --syntax sass, or you can uncomment this:
# preferred_syntax = :sass
# and then run:
# sass-convert -R --from scss --to sass sass scss && rm -rf sass && mv scss sass
