function out = read_list_file(path)
    f=fopen(path);
    t = textscan(f,'%s');
    fclose(f);
    out = t{:};
end