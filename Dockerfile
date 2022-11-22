FROM httpd:2.4

# Install required OS tools
RUN apt-get update; apt-get install -y perl git build-essential libcgi-session-perl curl imagemagick vim cpanminus

# Install required Perl modules
# RUN cpan DateTime
# RUN cpan DateTime::Set
# RUN cpan DateTime::Format::Epoch
# RUN cpan Astro::PAL
# RUN cpan Astro::Coords
# RUN cpan HTML::Template
# RUN cpan HTML::Template::Expr
# RUN cpan JSON
# RUN cpan DateTime::Format::RFC3339
# RUN cpan SVG::TT::Graph
# RUN cpan Tie::Handle::CSV
# RUN cpan LWP::Simple
# RUN cpan Text::CSV
# RUN cpan Switch

RUN cpanm --notest DateTime DateTime::Set DateTime::Format::Epoch Astro::PAL Astro::Coords HTML::Template HTML::Template::Expr JSON DateTime::Format::RFC3339 SVG::TT::Graph Tie::Handle::CSV LWP::Simple Text::CSV Switch Parallel::ForkManager


# Remove existing htdocs content
RUN rm -rf /usr/local/apache2/htdocs/*

# Download Tapir code into Apache htdocs webroot
RUN git clone https://github.com/aruethe2/Tapir.git /usr/local/apache2/htdocs/

# Download date-picker
RUN git clone https://github.com/freqdec/datePicker /usr/local/apache2/htdocs/src/date-picker-v5

# Set file permissions for datepicker files
RUN chmod -R o+rx /usr/local/apache2/htdocs/src/

# Fix code for new datepicker
RUN sed -i 's@m\-ds\-d\-ds\-Y@%m-%d-%Y@' /usr/local/apache2/htdocs/transits.cgi
RUN sed -i 's@m\-ds\-d\-ds\-Y@%m-%d-%Y@' /usr/local/apache2/htdocs/airmass.cgi

# Download transit targets
RUN curl -o /usr/local/apache2/htdocs/transit_targets.csv https://astro.swarthmore.edu/transits/transit_targets.csv

# Set up cgi for Apache
CMD httpd-foreground -c "LoadModule cgid_module modules/mod_cgid.so"
RUN sed -i 's/Options Indexes FollowSymLinks/Options Indexes FollowSymLinks ExecCGI\n    AddHandler cgi\-script \.cgi/g' /usr/local/apache2/conf/httpd.conf

# Add htdocs directory to Perl path
RUN echo "SetEnv PERL5LIB /usr/local/apache2/htdocs/" >> /usr/local/apache2/conf/httpd.conf

# Restart Apache to implement up new settings
RUN apachectl restart


