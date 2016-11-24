
public static immutable bool spoil_extensions = true;

public static immutable double deform_ratio = (1.0/(4+1)); // [0..1]

public static immutable double p_mk_empty_dir_here = 0.7; // [0..1]
public static immutable double p_mk_empty_dir_rec = 0.6; // [0..1]

public static immutable double p_rename_file = 0.2; // [0..1]

public static immutable double p_move_file = 0.2; // [0..1]
public static immutable double p_copy_file = 0.1; // [0..1]
//  p_move_file + p_copy_file < 1;

