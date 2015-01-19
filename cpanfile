requires 'DBI';
requires 'DBIx::Class';
requires 'File::Spec';
requires 'Filesys::Notify::Simple';
requires 'HTML::Entities';
requires 'JSON';
requires 'JSON::XS';
requires 'MIME::Base64::URLSafe';
requires 'Mail::RFC822::Address';
requires 'Mojolicious', '>= 5.05'; # introduced around_action hook
requires 'Template';
requires 'Template::Plugin::JSON', '>= 0.06';
requires 'Test::Most', 0;
requires 'Text::CSV', '>= 1.32';
requires 'Try::Tiny';
requires 'YAML';
requires 'Text::CSV';
requires 'LWP::UserAgent', '>= 5.827'; 
requires 'WWW::Mechanize', '>= 1.29_01'; 
requires 'DateTime::Format::MySQL';
requires 'DateTime', '>=1.0';
requires 'Crypt::OpenSSL::RSA';
requires 'Crypt::OpenSSL::AES';
requires 'Log::Any';

requires 'List::MoreUtils';
requires 'Class::Accessor::Fast';

requires 'Plack::Middleware::NoMultipleSlashes';
requires 'Data::UUID';
requires 'Moose', '>=2.1205';

requires 'DateTime::Format::ISO8601';
requires 'DateTime::Format::Strptime', '>= 1.0800';
requires 'LWP::Protocol::https';
requires 'Crypt::SSLeay';

requires 'XML::LibXSLT', '== 1.78';
requires 'Clone';

#### Testing
requires 'Class::Mockable';
test_requires 'Test::MockObject';
test_requires 'File::Share';
test_requires 'LWP::UserAgent::Mockable';
recommends 'Devel::Cover';

### Sending emails.
requires 'MIME::Entity';
requires 'Email::Abstract';
requires 'Email::Address';
requires 'Email::Sender';
requires 'MIME::Base64';
requires 'Authen::SASL';
requires 'Net::SMTP::SSL';
requires 'HTML::FormatText';

# shell
requires 'Pod::Text';
requires 'Devel::REPL';
requires 'File::Next';
requires 'Parse::HTTP::UserAgent';
