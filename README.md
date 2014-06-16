# Fluent::Plugin::Setsuna

Fluentd outpu plugin for Setsuna(CEP)
utpu plugin for Setsuna(CEP)
see Setsuna 
https://github.com/okuyamaoo/setsuna

## Installation

Add this line to your application's Gemfile:

    gem 'fluent-plugin-setsuna'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install fluent-plugin-setsuna

## Usage
Start Setsuna:

    Startup http setsuna server
    $ wget "https://github.com/okuyamaoo/setsuna/archive/v0.0.3.zip"
    $ unzip setsuna-{version}.zip
    $ cd setsuna-{version}
    $ java -classpath ./setsuna.jar:./*:./lib/jetty/* setsuna.core.SetsunaMain -httpserver true

Setting td-agent.conf:

    <match setsuna.**>
      type setsuna
      serveraddr 192.168.33.24 << Setsuna server ip address
      serverport 8080          << Setsuna server port (Default)
      unixtimeuse False
    </match>

Start td-agent


## Contributing

1. Fork it ( https://github.com/[my-github-username]/fluent-plugin-setsuna/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
