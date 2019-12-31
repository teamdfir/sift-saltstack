
package HTML::QuickTable;

=head1 NAME

HTML::QuickTable - Quickly create fairly complex HTML tables

=head1 SYNOPSIS

    use HTML::QuickTable;

    my $qt = HTML::QuickTable->new(
                   table_width  => '95%',       # opt method 1
                   td => {bgcolor => 'gray'},   # opt method 2
                   font_face => 'arial',        # set font
                   font => {face => 'arial'},   # same thing
                   labels => 1,                 # make top <th>?
                   stylesheet => 1,             # use stylesheet?
                   styleclass => 'mytable',     # class to use
                   useid  => 'results',         # id="results_r1c2" etc
                   header => 0,                 # print header?
             );

    my $table1 = $qt->render(\@array_of_data);

    my $table2 = $qt->render(\%hash_of_keys_and_values);

    my $table3 = $qt->render($object_with_param_method);

=cut

use Carp;
use strict;
use vars qw($VERSION %INDENT);

$VERSION = do { my @r=(q$Revision: 1.12 $=~/\d+/g); sprintf "%d."."%02d"x$#r,@r };
%INDENT  = (
   table => 0,
   tr    => 1,
   th    => 2,
   td    => 2,
);

sub _expopts {
    # This is a general-purpose option-parsing routine that
    # puts stuff down one level if it has a _ in it; this
    # allows stuff like "td_height => 50" and "td => {height => 50}"
    my $lev = shift || 0;
    my %opt = ();
    $lev++;
    while (@_) {
        my $key = shift;
        my $val = shift;
        if ($key =~ /^([a-zA-Z0-9]+)_(.*)/) {
            # looks like "td_height" or "font_face"
            $opt{$1}{$2} = $val;
        } elsif (ref $val eq 'HASH') {
            # this allows "table => {width => '95%'}"
            $opt{$key} = _expopts($lev, %$val);
        } elsif ($key eq 'font' && $lev == 1) {
            # special catch for two options to be FormBuilder-like
            $opt{font}{face} = $val;
        } elsif ($key eq 'lalign' && $lev == 1) {
            $opt{th}{align} = $val;
        } elsif ($key eq 'border' && $lev == 1) {
            # useful shortcut
            $opt{table}{border} = $val;
        } else {
            # put regular options in the top-level space
            $opt{$key} = $val;
        }
    }
    $lev--;
    return wantarray ? %opt : \%opt;
}

sub new {
    my $self = shift;
    my $class = ref($self) || $self;
    my %opt = _expopts(0, @_);

    # counters
    $opt{_level} = 0;
    $opt{_sentheader} = 0;

    # special options
    $opt{table}{border} = delete $opt{border} if exists $opt{border};  # legacy
    $opt{body} ||= {bgcolor => 'white'};
    $opt{null} ||= '';      # prevents warnings

    # stylesheet handling
    if ($opt{stylesheet}) {
        $opt{styleclass} ||= 'qt';
        delete $opt{font};  # kill font
    }

    # setup our font tag separately
    # do this here or else every call to render() must do it
    ($opt{_fo}, $opt{_fc}) = $opt{font}
                                ? (_tag('font', %{$opt{font}}), '</font>')
                                : ('','');

    return bless \%opt, $class;
}

# Internal tag routines stolen from CGI::FormBuilder, which
# in turn stole them from CGI.pm

sub _escapeurl ($) {
    # minimalist, not 100% correct, URL escaping
    my $toencode = shift || return undef;
    $toencode =~ s!([^a-zA-Z0-9_,.-/])!sprintf("%%%02x",ord($1))!eg;
    return $toencode;
}

sub _escapehtml ($) {
    defined(my $toencode = shift) or return '';
    eval { require  HTML::Entities };
    if ($@) {
        # not found; use very basic built-in HTML escaping
        $toencode =~ s!&!&amp;!g;
        $toencode =~ s!<!&lt;!g;
        $toencode =~ s!>!&gt;!g;
        $toencode =~ s!"!&quot;!g;
        return $toencode;
    } else {
        # dispatch to HTML::Entities
        return HTML::Entities::encode($toencode);
    }
    return $toencode;
}

sub _tag ($;@) {
    # called as _tag('tagname', %attr)
    # creates an HTML tag on the fly, quick and dirty
    my $name = shift || return;
    my @tag;
    my %saw = ();   # prevent dups
    while (@_) {
        # this cleans out all the internal junk kept in each data
        # element, returning everything else (for an html tag)
        my $key = lc shift;
        my $val = _escapehtml shift;    # minimalist HTML escaping
        push @tag, qq($key="$val") unless $saw{$key}++;
    }
    return '<' . join(' ', $name, sort @tag) . '>';
}

sub _tohtml ($) {
    defined(my $text = shift) or return;

    # Need to catch the < and > commonly used in emails
    $text = _escapehtml($text);

    # A couple little catches
    $text =~ s!\*([^\*]+)\*!<b>$1</b>!g;
    $text =~ s!\_([^\_]+)\_!<i>$1</i>!g;

    # Also catch links - remember there are a LOT of assumptions here!!!
    $text =~ s!(http[s]?://[\=\.\-\/\w+\?]+)(\s+)!<a href="$1">$1</a>$2!g;
    $text =~ s!([\w\.\-\+\_]+\@[\w\-\.]+)!<a href="mailto:$1">$1</a>!g;       # email addrs

    return $text;
}

sub _toname ($) {
    # creates a name from a var/file name (like file2name)
    my $name = shift;
    $name =~ s!\.\w+$!!;        # lose trailing ".cgi" or whatever
    $name =~ s![^a-zA-Z0-9.-/]+! !g;
    $name =~ s!\b(\w)!\u$1!g;
    return $name;
}

# These handle styleclass and id generation, if requested
sub _getclass {
    my $self = shift;
    return '' unless $self->{stylesheet};
    my $row  = shift || 0;  # is a row

    # if styleclass is an array, alternate between
    my $class = '';
    if (ref $self->{styleclass} eq 'ARRAY') {
        if ($row && $self->{_notfirstrow}) {   # only alternate rows
            push @{$self->{_tmpclass}||=[]}, shift @{$self->{styleclass}};
            unless (@{$self->{styleclass}}) {
                # have pushed thru all, so start over
                $self->{styleclass} = delete $self->{_tmpclass};
            }
        }
        $class = $self->{styleclass}[0];
    } else {
        $class = $self->{styleclass};
    }
    return $class;
}

# Generate a unique id for each element
sub _getid {
    my $self = shift;
    return '' unless $self->{useid};
    my $base = join '', @_;  # rest is 'r', 42, 'c', 15, etc
    return $base ? "$self->{useid}_$base" : $self->{useid};
}

# Keep track of the appropriate indent
sub _indent {
    local $^W = 0;
    my $self = shift;
    my $what = shift;   # element name
    return '  ' x $INDENT{$what};
    my $last = $self->{_lastidt} || '';
    if (! $last) {
        # first layer
        $self->{_indent} = 0;
    } elsif ($what eq $last) {
        # nothing, same
        $self->{_indent} ||= 0
    } elsif ($INDENT{$what} > $INDENT{$last}) {
        # use it as a base
        $self->{_indent}++;
    } elsif ($INDENT{$what} < $INDENT{$last}) {
        # we're nesting
        $self->{_indent}--;
    }
    $self->{_lastidt} = $what;
    return '  ' x ($self->{_indent} * $INDENT{$last});
}

# This recursively renders a data structure into a table
sub render {
    # Do the work and return as a scalar
    my $self = shift;
    my($data, $html) = ('','');
    my $ref = ref $_[0];
    if (@_ > 1) {
        # assume that it's an array
        $ref = 'ARRAY';
        $data = [ @_ ]; 
    } elsif ($ref) {
        # shift it
        $data = shift;
    } elsif (! $self->{_level}) {
        croak '[HTML::QuickTable] Argument to render() must be \@array, \%hash, or $object';
    } else {
        $ref = 'ARRAY';
        $data = [ @_ ]; 
    }

    # We expand data differently depending on what type of structure it is
    # Truthfully, all this sub can handle is arrayrefs. Everything else
    # is converted on the fly by the "else" statement to an arrayref and
    # this sub is recursively called.

    if ($ref eq 'ARRAY') {

        # create our opening table tag
        my $tab = $self->{_level} ? {width => '100%'} : $self->{table};
        $tab->{id}    = $self->_getid    if $self->{useid};
        $tab->{class} = $self->_getclass if $self->{stylesheet};
        $html .= _tag('table', %$tab) . "\n" unless ++$self->{_level} == 2;

        my @tmprow = ();
        if ($self->{vertical} && ref $data->[0] eq 'ARRAY') {
            # Whole different algorithm, here we must iterate in a column-
            # based manner, not a row-based one. This means walking the
            # array "backwards". Notice the for loops iterate inside-out.
            for (my $ci=0; $ci < @{$data->[0]}; $ci++) {
                $tmprow[$ci] = [];
                for (my $ri=0; $ri < @$data; $ri++) {
                    push @{$tmprow[$ci]}, $data->[$ri][$ci]; 
                }
            }
        } else {
            # non-vertical or already expanded/rearranged
            @tmprow = @$data;
        }

        # Now, walk all arrays in the same manner, since vert's were rearranged
        my $colnum = 0;
        $self->{_rownum} ||= 0;
        for my $row (@tmprow) {
            unless ($self->{_level} == 2) {
                $self->{tr}{id}    = $self->_getid('r', ++$self->{_rownum}) if $self->{useid};
                $self->{tr}{class} = $self->_getclass(1) if $self->{stylesheet};
                $html .= ' ' . _tag('tr', %{$self->{tr}}) . "\n";
            }
            if ($self->{_level} == 1) {
                $html .= $self->render($row);
            }
            else {
                # For an array, we do not generate <th> each time, only the first
                # time per the row/column
                my $td = 'td';
                if (my $l = $self->{labels}) {
                    if (($l =~ /[1T]/i && ! $self->{_notfirstrow})
                      || ($l =~ /L/i && ! $colnum)
                      || ($l =~ /R/i && $colnum == (@tmprow-1))
                    ) {
                        $td = 'th';
                    } elsif ($l =~ /B/i) {
                        croak "[HTML::QuickTable] Sorry, labels => 'B' is broken - want to patch it?";
                    }
                }

                # Catch td class stuff
                $self->{$td}{id}    = $self->_getid('r', $self->{_rownum}, 'c', $colnum+1) if $self->{useid};
                $self->{$td}{class} = $self->_getclass if $self->{stylesheet};

                # Recurse data structures
                if (ref $row) {
                    $html .= '  ' . _tag($td, %{$self->{$td}}) . $self->{_fo} 
                                  . $self->render($row) . $self->{_fc} . "</$td>\n";
                }
                else {
                    $row = _toname($row) if $self->{nameopts} && $td eq 'th';
                    $row = _tohtml($row) if $self->{htmlize};
                    my $tdptr = $self->{$td};
                    unless (defined $row) {
                        # "null", so alter HTML accordingly
                        $row = $self->{null};
                        $tdptr = $self->{nulltags} if $self->{nulltags};
                        $tdptr->{id}    = $self->_getid('r', $self->{_rownum}, 'c', $colnum+1) if $self->{useid};
                        $tdptr->{class} ||= $self->_getclass if $self->{stylesheet};
                    }
                    $html .= '  ' . _tag($td, %{$tdptr}) . $self->{_fo}
                                  . $row . $self->{_fc} . "</$td>\n";
                }
            }
            unless ($self->{_level} == 2) {
                $html .= " </tr>\n";
            }
            $colnum++;
        }
        $html .= '</table>' unless $self->{_level}-- == 2 ;

    } else {

        # Must expand the data structure carefully
        if ($ref eq 'HASH') {
            # This assumes that the data struct is consistent; we cannot
            # handle any other kind because of our assumptions
            # Guess struct based on the first key we see
            my $key = each %$data;
            my @new = ();
            if (ref $data->{$key} eq 'HASH') {
                # keylabel => {colname => value, colname => value}

                # this bit of "pre-scanning" gets all the available
                # column names in our data
                my %cols;
                my @rows = sort keys %$data;
                for my $row (@rows) {
                    $cols{$_}++ for keys %{$data->{$row}};
                } 

                # Now that we have a list of all our columns, we must
                # re-iterate through all our rows (again!) to get vals
                my @cols = sort keys %cols;
                for my $row (@rows) {
                    my @thisrow = ();
                    for my $col (@cols) {
                        $data->{$row}{$col} ||= undef;  # causes autoviv
                        #if (ref $data->{$row}{$col} &&
                            #ref $data->{$row}{$col} ne 'ARRAY')
                        #{
                            # recursively call for refs
                            #push @thisrow, $self->render($data->{$row}{$col});
                        #} else {
                            #my $val = ref $data->{$row}{$col} eq 'ARRAY'
                                            #? $data->{$row}{$col} : [$data->{$row}{$col}];
                            #push @thisrow, [$row, @$val];
                            push @thisrow, $data->{$row}{$col};
                        #}
                    }
                    push @new, [$row, @thisrow];
                }
                my $keylabel = $self->{keylabel} || '';
                unshift @new, [$keylabel, @cols];
            }
            elsif (ref $data->{$key} eq 'ARRAY' || ! ref $data->{$key}) {
                # keylabel => [value, value, value] or keylabel => value

                for my $row (sort keys %$data) {
                    my $val = ref $data->{$row} eq 'ARRAY' ? $data->{$row} : [$data->{$row}];
                    push @new, [$row, @$val];
                }
            }
            # both methods above will fill up @new
            $html .= $self->render(\@new);
        }
        elsif ($ref && UNIVERSAL::can($ref, 'param')) {
            # object with param method
            my @keys = $data->param;
            $self->{labels} = 1;
            my @new = ();
            for my $key (@keys) {
                my(@val) = $data->param($key);
                my $val  = @val > 1 ? \@val : $val[0];
                push @new, $val;
            }
            $data = [\@keys, \@new];
            $html .= $self->render($data);
        }
    }

    if ($self->{header} && ! $self->{_level} && ! $self->{_sentheader}++) {
        my $title = $self->{title} ? ('<title>'._escapehtml($self->{title})."</title>\n") : '';
        my $h3    = $self->{title} ? "<h3>$self->{title}</h3>\n" : '';
        my $style = ($self->{stylesheet} && $self->{stylesheet} ne 1)
                        ? qq(<link rel="stylesheet" href="$self->{stylesheet}" />\n) : '';
        my $text  = $self->{text} ? "$self->{text}\n" : '';

        $html = "Content-type: text/html; charset=iso-8859-1\n\n" . '<html>'    # fuck doctypes, really
              . "\n" . _tag('head', %{$self->{head}}) . "\n" . $style . $title . "</head>\n"
              . _tag('body', %{$self->{body}}) . $self->{_fo} . "\n" 
              . $h3 . $text . $html . $self->{_fc} . "</body></html>\n";
    }

    # detect what row we're in by counting down and up
    $self->{_notfirstrow} = $self->{_level};

    return $html;
}

1;

__END__

=head1 DESCRIPTION

This modules lets you easily create HTML tables. Like B<CGI::FormBuilder>,
this module does a lot of thinking for you. For a comprehensive
module that gives you the ability to tweak every aspect of table building,
see B<HTML::Table> or B<Data::Table>. This one gives you a lot of control,
but is really designed as an easy way to expand arbitrary data structures.

The simplest table can be created with nothing more than:

    my $qt = HTML::QuickTable->new;
    print $qt->render(\@data);

Where C<@data> would be an array holding your data structure. For example,
the data structure:

    @data = (
        [ 'nwiger', 'Nathan Wiger', 'x43264', 'nate@wiger.org' ],
        [ 'jbobson', 'Jim Bobson', 'x92811', 'jim@bobson.com' ]
    );

Would be rendered as something like:

    <table>
    <tr><td>nwiger</td><td>Nathan Wiger</td><td>x43264</td><td>nate@wiger.org</td></tr>
    <tr><td>jbobson</td><td>Jim Bobson</td><td>x92811</td><td>jim@bobson.com</td></tr>
    </table>

Of course, the best use for this module is on dynamic data, say something
like this:

    use DBI;
    use HTML::QuickTable;

    my $qt = HTML::QuickTable->new(header => 1);    # print header
    my $dbh = DBI->connect( ... );

    my $all_arrayref = $dbh->selectall_arrayref("select * from billing");
    
    print $qt->render($all_arrayref);

With C<< header => 1 >>, you will get a brief C<CGI> header as well as
some basic C<HTML> to prettify things. As such, the above will print
out all the rows that your query selected in an C<HTML> table.

=head1 FUNCTIONS

=head2 new(opt => val, opt => val)

The C<new()> function takes a list of options and returns a C<$qt>
object, which can then be used to C<render()> different data. The
C<new()> function has a flexible options-parsing mechanism that 
allows you to specify settings to pretty much any element of the
table.

Options include:

=over

=item header => 1 | 0

If set to C<1>, a basic C<CGI> header and leading C<HTML> is printed
out. Useful if you're really looking for quick and dirty. Defaults
to C<0>.

=item htmlize => 1 | 0

If set to 1, then all values will be run through a simple filter that
creates links for things that look like email addresses or websites.
Also, C<*word*> will be changed to C<< <b>word</b> >>, and C<_word_>
will be changed to C<< <i>word</i> >>.

=item labels => 1 | 0 | LTRB

If set to 1, then the first row of the data is used as the labels
of the data columns, and is placed in C<< <th> >> tags. For example,
if we assume our above data structure, and said:

    my $qt = HTML::QuickTable->new(... labels => 1);

    unshift @data, ['User', 'Name', 'Ext', 'Email'];

    print $qt->render(\@data);

You would get something like this:

    <table>
    <tr><th>User</th><th>Name</th><th>Ext</th><th>Email</th></tr>
    <tr><td>nwiger</td><td>Nathan Wiger</td><td>x43264</td><td>nate@wiger.org</td></tr>
    <tr><td>jbobson</td><td>Jim Bobson</td><td>x92811</td><td>jim@bobson.com</td></tr>
    </table>

Since the labels are placed in C<< <th> >> tags, you can then use
the extra C<HTML> options described below to alter the way that the
labels look. 

You can also set this to a string that includes the characters
L, T, R, and B, to specify that C<< <th> >> tags should be created
for the Left, Top, Right, and Bottom rows and columns. So for example:

    labels => 'LT'

Would alter the table so that both the first row AND first column
had C<< <th> >> instead of C<< <td> >> elements. This is useful
for creating tables that have two axes, such as calendars.

=item null => $string

If set, then null (undef) fields will be set to that string instead.
This is useful if pulling a bunch of records out of a database and
not wanting to get blank table spaces everywhere there's a null field.
For example:

    my $qt = HTML::QuickTable->new(null => '-');
    my $all_arrayref = $sth->fetchall_arrayref;
    print $qt->render($all_arrayref);

By default null table elements are left blank.

=item nulltags => \%hash

In addition to just changing the string used to represent null data,
you may want to change the look of it as well. These tags will become
attributes to the C<< <td> >> element holding the null field. So, 
settings like this:

    null => 'N/A',
    nulltags => {bgcolor => 'gray'},

Would result in an element like the following for null fields:

    <td bgcolor="gray">N/A<td>

Make sense?

=item stylesheet => 1 | '/path/to/style.css'

If set, then any font settings are ignored and instead all table
elements are wrapped with a C<class=> attribute. The class name
is whatever C<styleclass> is set to (see below). See also the
C<useid> option to generate C<id> tags in an intelligent way.

=item styleclass => $string | \@array

This used as a style class to use if the above setting is used.
If set to a string, it is passed directly to the C<class> tag.
If set to an arrayref, then those styles are alternated between
on a row-by-row (C<tr>) basis. For example:

    styleclass => [qw(one two)]

Would yield C<XHTML> similar to:

    <table class="one">
      <tr class="one">
        <td class="one">a</td>
        <td class="one">b</td>
        <td class="one">c</td>
        <td class="one">d</td>
      </tr>
      <tr class="two">
        <td class="two">e</td>
        <td class="two">f</td>
        <td class="two">g</td>
        <td class="two">h</td>
      </tr>
    </table>

Notice that the table gets the style of the first array element.

=item text => $string

Just like B<FormBuilder>, this text is printed out for you to easily
annotate your table.

=item title => $string

If you set C<< header => 1 >>, then you can also specify the C<title>
to be prefixed to the document. Otherwise this option is ignored.

=item useid => $baseid

If set, then unique C<id> tags are automatically generated for each
and every table element, allowing you to address the entire table
on a per-element basis via Javascript or CSS. These tags take the
format:

    $baseid[_rX[cY]]

Where C<X> is the row number and C<Y> is the column number. So
this setting:

    useid => 'results'

Would yield C<XHTML> like:

    <table id="results">
      <tr id="results_r1">
        <th id="results_r1c1">n1</th>
        <th id="results_r1c2">n2</th>
        <th id="results_r1c3">n3</th>
        <th id="results_r1c4">n4</th>
      </tr>
      <tr id="results_r2">
        <td id="results_r2c1">1</td>
        <td id="results_r2c2">2</td>
        <td id="results_r2c3">3</td>
        <td id="results_r2c4">4</td>
      </tr>
    </table>

Notice that the table gets the baseid verbatim.

=item vertical => 1 | 0

If you set this to 1, then it fundamentally changes the way in which
data is expanded. Instead of walking the data structure and building
rows horizontally, each element of data will become a column. This
option is described more below under C<render()>.

=item body => {opt => val, opt => val}

=item font => {opt => val, opt => val}

=item table => {opt => val, opt => val}

=item td => {opt => val, opt => val}

=item th => {opt => val, opt => val}

=item tr => {opt => val, opt => val}

These options can be used to set attributes to be used on the applicable
tag. For example, if you wanted the table width to be C<95%> and the
C<border> to be C<1>, you would say:

    my $qt = HTML::QuickTable->new(table => {width => '95%', border => 1});

Of course, you can specify as many different options as you want:

    my $qt = HTML::QuickTable->new(table => {width => '95%', border => 1},
                                   td    => {class => 'td_el'},
                                   font  => {face => 'arial,helvetica'} );

As an alternative form, you can also use:

=item body_opt => val

=item font_opt => val

=item table_opt => val

=item td_opt => val

=item th_opt => val

=item tr_opt => val
   
Instead of having to specify a hashref, you can use this option
form to specify C<HTML> tags.  For example, if you want to set the
font face, either of these will do the exact same thing:

    my $qt = HTML::QuickTable->new(font => {face => 'verdana'});
    my $qt = HTML::QuickTable->new(font_face => 'verdana');

Again, you can specify any C<HTML> tag you want and it will get
included. Anything after the underscore is taken as the tag
name and placed into the output C<HTML> verbatim.

=back

=head2 render(\@data | \%data | $object) 

The C<render()> function can accept either an C<arrayref>, C<hashref>,
or C<object>. It then recursively expands the data per the options
you specified to C<new()>. Each data structure is rendered differently:

=over

=item arrayref (\@array)

An C<arrayref> should expand intuitively; each row in the array
becomes another row in the table. If you specify the C<labels>
option, then the first row is taken as the column labels and is
placed within C<< <th> >> elements.

=item object ($object)

An C<object> also expands quite simply. First, the C<object>'s
C<param()> method is called to get a list of keys. Then, for
each key the value is placed in the array. The key is taken as
the label for that column, and is placed within a C<< <th> >>.
As an example, you can dump a nice table of your C<CGI> query with:

    use CGI;
    use HTML::QuickTable;

    my $cgi = CGI->new;
    my $qt  = HTML::QuickTable->new(header => 1);

    print $qt->render($cgi); 

=item hashref (\%hash)

A C<hashref> is first sorted by C<key>. Then, each data element
becomes a data element for that column. For example:

    %user = (
        'nwiger'  => ['Nathan Wiger', 'nate@wiger.org'],
        'jbobson' => ['Jim Bobson', 'jim@bobson.com']
    );

    print $qt->render(\%user);

Would be rendered as:

    <table>
    <tr><td>jbobson</td><td>Jim Bobson</td><td>jim@bobson.com</td></tr>
    <tr><td>nwiger</td><td>Nathan Wiger</td><td>nate@wiger.org</td></tr>
    </table>

Note that it's very similar to the way arrays are handled. The benefit
here is that this allows you to expand arbitrary data structures.

If it's a C<hashref> of C<hashrefs>, for example:

    %user = (
        'nwiger'  => { name => 'Nathan Wiger', email => 'nate@wiger.org' },
        'jbobson' => { name => 'Jim Bobson', email => 'jim@bobson.com'}
    );

    print $qt->render(\%user);

Then some Major Magic (tm) happens and you'll get something like this:

    <table>
    <tr><th></th><th>email</th><th>name</th></tr>
    <tr><td>jbobson</td><td>jim@bobson.com</td><td>Jim Bobson</td></tr>
    <tr><td>nwiger</td><td>nate@wiger.org</td><td>Nathan Wiger</td></tr>
    </table>

Notice that the keys were sorted alphabetically and output in order.
But, note that the top-level C<key> is not labeled in the C<< <th> >>.
To change this, you must specify the C<keylabel> option to C<new()>:

    my $qt = HTML::QuickTable->new(keylabel => 'user');
    # ...
    print $qt->render(\%user);

That would create the same C<HTML> as above, except the first column
label would be "user".

=back

=head1 NOTES

The 'B' option to 'labels' is currently broken, due to the fact that
C<render()> recursively calls itself and thus loses track of where
it is. But who the heck puts labels at the I<bottom> of an HTML table??

If you run into a bug, please DO NOT submit it via C<rt.cpan.org> - that
just causes me alot of extra work. Email me at the below address, and
include the version string your eyes are about to pass over.

=head1 SEE ALSO

L<HTML::Table>, L<Data::Table>, L<SQL::Abstract>, L<CGI::FormBuilder>

=head1 VERSION

$Id: QuickTable.pm,v 1.12 2005/05/10 21:10:52 nwiger Exp $

=head1 AUTHOR

Copyright (c) 2001-2005 Nathan Wiger <nate@wiger.org>. All Rights Reserved.

This module is free software; you may copy this under the terms of
the GNU General Public License, or the Artistic License, copies of
which should have accompanied your Perl kit.

=cut

