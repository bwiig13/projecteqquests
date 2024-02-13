use strict;
use warnings;
use DBI;

# Subroutine to calculate new ID
sub calculate_new_id {
    my ($id, $name) = @_;
    my $new_id = $id; # Default to original ID

    if ($name =~ /^Rose Colored/) {
        # Assuming the 'normal' ID can be directly inferred (which may need adjustment)
        $new_id = ($id < 100000) ? ($id - 70000) : ($id - 700000);
        $new_id += 1000000; # Apply +1 million offset
    } elsif ($name =~ /^Apocryphal/) {
        # Similarly, adjust based on actual logic for 'Apocryphal' items
        $new_id = ($id < 100000) ? ($id - 80000) : ($id - 800000);
        $new_id += 2000000; # Apply +2 million offset
    }

    return $new_id;
}

sub add_new_item_rows {
    my ($dbh,$item_type) = @_;
    my $prefix = $item_type eq 'Rose Colored' ? 'Rose Colored' : 'Apocryphal';
    my $like_pattern = $prefix . '%';

    # Fetch 'Rose Colored' or 'Apocryphal' items
    my $sth = $dbh->prepare("SELECT * FROM items WHERE name LIKE ?");
    $sth->execute($like_pattern);

    # Dynamically determine column names, excluding 'id'
    my @columns = @{$sth->{NAME_lc}};
    my $id_index = grep { $columns[$_] eq 'id' } 0..$#columns;
    splice(@columns, $id_index, 1); # Remove 'id' from column names
    
    my $columns_list = join(", ", @columns); # For SQL INSERT, excluding 'id'
    my $placeholders = join(", ", map { "?" } @columns); # Placeholders for values
    
    my $insert_item_sql = "INSERT INTO items (id, $columns_list) VALUES (?, $placeholders)";
    my $insert_item_sth = $dbh->prepare($insert_item_sql);

    my $insert_map_sql = "INSERT INTO item_id_mapping (old_id, new_id) VALUES (?, ?)";
    my $insert_map_sth = $dbh->prepare($insert_map_sql);

    # Define the delete statement for old items
    my $delete_sql = "DELETE FROM items WHERE id = ?";
    my $delete_sth = $dbh->prepare($delete_sql);

    while (my $row = $sth->fetchrow_hashref) {
        my $new_id = calculate_new_id($row->{id}, $row->{name});
        
        # Prepare values for insertion, excluding 'id'
        my @values = map { $row->{$_} } @columns;
        
        # Insert the new item row with the new ID
        $insert_item_sth->execute($new_id, @values);

        # Insert the mapping from old ID to new ID
        $insert_map_sth->execute($row->{id}, $new_id);

        # Delete the old item row
        $delete_sth->execute($row->{id});
    }
}

sub update_secondary_table_item_ids {
    my ($dbh,$table_name, $column_name) = @_;

    # Prepare the SQL statement for updating the table
    my $update_sql = "UPDATE $table_name SET $column_name = (SELECT new_id FROM item_id_mapping WHERE old_id = $table_name.$column_name)";
    my $update_sth = $dbh->prepare($update_sql);

    # Execute the update
    $update_sth->execute();

    # Check for errors
    if ($update_sth->err) {
        warn "Error updating $table_name: " . $update_sth->errstr;
    } else {
        print "Updated item IDs in $table_name successfully.\n";
    }
}

# Database connection details
my $dbname = 'peq';
my $host = 'mariadb';
my $port = '3306'; # default MySQL port
my $user = 'eqemu';
my $password = 'dDye40WrWKOn2LwQDxAPK5dJIzSeNmh';

# DSN for MySQL connection
my $dsn = "DBI:mysql:database=$dbname;host=$host;port=$port";

# Connect to the database
my $dbh = DBI->connect($dsn, $user, $password, { RaiseError => 1, AutoCommit => 0 }) or die $DBI::errstr;

add_new_item_rows($dbh,'Rose Colored');
add_new_item_rows($dbh,'Apocryphal');

update_secondary_table_item_ids($dbh,'sharedbank', 'itemid');
update_secondary_table_item_ids($dbh,'inventory', 'itemid');
update_secondary_table_item_ids($dbh,'lootdrop_entries', 'item_id');

# Commit the changes and clean up
$dbh->commit;
$dbh->disconnect;
