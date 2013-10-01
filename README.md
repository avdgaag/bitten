# Bitten [![Build Status](https://secure.travis-ci.org/avdgaag/bitten.png?branch=master)](http://travis-ci.org/avdgaag/bitten)

## Introduction

Bitten is a simple module for adding multiple boolean flags to any Ruby object,
that internally get stored as a single integer attribute. If your Ruby object
is an ActiveRecord object, it also provides some convenience scopes for you.

The advantage is a simple data model, with a single attribute containing many
bits of information. You can keep adding more flags to the list of tracked
flags, as long as the order of existing flags is kept intact.

## Installation

Bitten is distributed as a Ruby gem, which should be installed on most Macs and
Linux systems. Once you have ensured you have a working installation of Ruby
and Ruby gems, install the gem as follows from the command line:

    gem install bitten

TO use it in projects using Bundler, add the gem to your `Gemfile`:

    gem 'bitten'

Then, install your gems:

    bundle install

## Usage

Here's an example of how to use Bitten:

     ActiveRecord::Migration.create_table do |t|
       t.integer :bits, null: false, default: 0
     end
  
     class User < ActiveRecord::Base
       include Bitten
       has_bits :editor, :author, :reviewer
     end
  
     user = User.new editor: true
     user.editor? # => true
     user.author? # => false
     user.reviewer? # => false
     user.author = true
     user.author? # => true
     user.save
     User.author # => [user]
     User.editor # => [user]
     User.reviewer # => []
     User.not_reviewer # => [user]

### Documentation

See the inline [API
docs](http://rubydoc.info/github/avdgaag/bitten/master/frames) for more
information.

## Other

### Note on Patches/Pull Requests

1. Fork the project.
2. Make your feature addition or bug fix.
3. Add tests for it. This is important so I don't break it in a future version
   unintentionally.
4. Commit, do not mess with rakefile, version, or history. (if you want to have
   your own version, that is fine but bump version in a commit by itself I can
   ignore when I pull)
5. Send me a pull request. Bonus points for topic branches.

### Issues

Please report any issues, defects or suggestions in the [Github issue
tracker](https://github.com/avdgaag/bitten/issues).

### What has changed?

See the [HISTORY](https://github.com/avdgaag/bitten/blob/master/HISTORY.md) file
for a detailed changelog.

### Credits

Created by: Arjan van der Gaag  
URL: [http://arjanvandergaag.nl](http://arjanvandergaag.nl)  
Project homepage: [http://avdgaag.github.com/bitten](http://avdgaag.github.com/bitten)  
Date: september 2013  
License: [MIT-license](https://github.com/avdgaag/bitten/blob/master/LICENSE) (same as Ruby)
