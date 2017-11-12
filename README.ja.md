# IoT実証実験のためのCaptive Portal

本プロジェクトではIoT実証実験におけるエンドユーザ承諾を得るため，Free Wi-FiのCaptive Portalを活用する．現状のCaptive Portalはエンドユーザが快適に利用する上でいくつかの課題を抱えている．これらの課題解決のため，我々はCaptive Portalのプロトタイプ実装を提供し，新たな機能のテストを容易にする．以下プロトタイプ実装の利用方法について述べる．

## インストール

このドキュメントでは以下のパラメータを用いる．以下ではフロントエンドにApache HTTPD，Application ContainerとしてPassengerの利用を想定しているが，Nginxを利用した場合も，ほぼ同様な手順で利用が可能である．

- DOCUMENT_ROOT: フロントエンドWebサーバのDocumentRoot（例：/var/www/html，/Library/WebServer/Documents）


### コードのcloneとリンクの作成

githubから最新のコードをcloneし，適切な設定を行うことで利用する．

```
cd $DOCUMENT_ROOT
mkdir ../webapps
cd webapps
git clone https://github.com/toyokazu/captive_portal.git
cd captive_portal
bundle install
env RAILS_ENV=production rake db:migrate
cd $DOCUMENT_ROOT
ln -s $DOCUMENT_ROOT/../webapps/captive_portal/public ./captive_portal
```


### アプリケーションの設定

#### SNS認証（omniauth）の設定

連携するSNSに対してアプリケーションを登録し，アプリケーションID，アプリケーションkeyをそれぞれのSNSに対して登録する必要がある．

例）facebookの場合
FACEBOOK_KEY, FACEBOOK_SECRETを設定する必要あり．

これらの値は環境変数として設定する．設定方法は，後述のApacheの場合の例を参照のこと．

その他，設定可能なオプション，例えばSNS認証で取得する属性の調整などは，それぞれのomniauth strategyのドキュメントを参照のこと．

- omniauth-facebook
- omniauth-twitter
- omniauth-google-oauth2

なお，取得した属性をAuthHashのどの属性にマッピングするのか，また，AttributeLogとして，どの属性を残すのか，については，app/controllers/application_controller.rbのextract_attributeメソッドおよびdb/migrate/20171022074755_create_attribute_logs.rbなどで修正できる．


#### AP認証の設定

AP認証については，指定したap_typeによって，複数のAPに対応できる実装にしているが，現状Arubaの実装のみを含んでいる．

- Arubaの場合

ARUBA_USER, ARUBA_PASSWORD の環境変数設定が必要となる．設定方法は後述のApacheの設定を参照のこと．


#### secret_key_baseの設定

他の環境変数と同様にSECRET_KEY_BASEも設定する．


### Passengerの設定

以下ではRailsをPassengerで動作させる場合について，設定例を示す．

Passengerのインストール方法は以下のページで確認できる．

https://github.com/phusion/passenger

ここではrubygemsを用いてインストールする．/usr/local/rbenv以下にrbenvがインストールされており，rubyはrbenvのものを利用していると想定する．

```
gem install Passenger
/usr/local/rbenv/shims/passenger-install-apache2-module
```


#### アプリケーションの再起動

touch tmp/restart.txt


### Apache(Webフロントエンド)の設定

##### 以下のkey値については適当にXXXXなどに置き換える．

secret_key_baseの生成は
```
rake secret
b35d4d8dc009283cb3c6560eb7a6d99e23a38aee0fc3a7f06998d46a5a2faa21e6a95efbf7c8375467169e97ad6a8ca53592781b9fa66c32766dddefe55027ec
```
で出力された値を用いる．設定方法は，Apache等のフロントエンドの設定で，下記のようにSECRET_KEY_BASE環境変数に設定する．以下はMacOSでの設定例である．適宜設定ファイルのパス名は読み替えて設定すること．

```
vi /etc/apache2/extra/httpd-ssl.conf
Alias /captive_portal /Library/WebServer/webapps/captive_portal/public
<Location /captive_portal>
  SetEnv SECRET_KEY_BASE XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
  SetEnv FACEBOOK_KEY XXXXXXXXXXXXXXXX
  SetEnv FACEBOOK_SECRET XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
  SetEnv ARUBA_USER XXXXXXXXXX
  SetEnv ARUBA_PASSWORD XXXXXXXXXX
  PassengerBaseURI /captive_portal
  PassengerAppRoot /Library/WebServer/webapps/captive_portal
</Location>

<Directory /Library/WebServer/webapps/captive_portal/public>
  Allow from All
  #Deny from All
  Options -MultiViews
  # Uncomment this if you're on Apache >= 2.4:
  Require all granted
</Directory>
```

以下はapache2用のpassenger_module (mod_passenger)の設定例である．username, groupname を対象のWebアプリケーションを動作させるユーザ名，グループ名に修正して利用する．

```
vi /etc/apache2/other/passenger.conf
LoadModule passenger_module /usr/local/rbenv/versions/2.4.2/lib/ruby/gems/2.4.0/gems/passenger-5.1.8/buildout/apache2/mod_passenger.so
<IfModule mod_passenger.c>
  PassengerRoot /usr/local/rbenv/versions/2.4.2/lib/ruby/gems/2.4.0/gems/passenger-5.1.8
  PassengerDefaultRuby /usr/local/rbenv/shims/ruby
  PassengerUser username
  PassengerGroup groupname

  PassengerFriendlyErrorPages on
</IfModule>
```
