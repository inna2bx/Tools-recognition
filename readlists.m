function [images, labels, back_grounds]=readlists()
  f=fopen('List Files\images.list');
  z = textscan(f,'%s');
  fclose(f);
  images = z{:}; 

  f=fopen('List Files\labels.list');
  l = textscan(f,'%s');
  labels = l{:};
  fclose(f);

  f=fopen('List Files\back_grounds.list');
  bg = textscan(f,'%s');
  back_grounds = bg{:};
  fclose(f);
end
