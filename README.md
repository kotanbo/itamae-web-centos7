# itamae web centos7

create web application environment by itamae

## Requirement

- CentOS 7

## Usage

install gem.
```
bundle install --path vendor/bundle
```

run
```
bundle exec itamae ssh -i ~/.ssh/id_rsa_example_jp -u root -h host001.example.jp -y nodes/node.yml roles/web.rb
```

dry run
```
bundle exec itamae ssh -i ~/.ssh/id_rsa_example_jp -u root -h host001.example.jp -y nodes/node.yml roles/web.rb -n
```