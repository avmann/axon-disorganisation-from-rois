//Macro to tabulate axon lengths and disorganisation areas of disorganised axons from roi markings v0.5.6 by Andre Voelzmann

macro "axon disorganisation from rois [q]" {
function tableF3() {
/* p is line number */
/* k is new line number for addons */
/* t is new line number of disorg area start -1 */
		for (p=0; p<n; p++){
		V2=getResult("Length", p);
		V3=getResult("Area", p);
		Vt=getResult("Length", p-1);
		if (V2==0 && Vt==0)
			{Vo=getResult("disorganised area", s);
			V4=Vo+V3;
			setResult("disorganised area", s, V4);
			k=s;}
		else if (V2==0 && Vt>=0)
			{s=k-1;
			setResult("disorganised area", s, V3);
			k=s;}
		else {setResult("axon length", k, V2);
			setResult("disorganised area", k, 0);};
		k=k+1;
		}
	}

function append(arr, value) {
	newlength=arr.length+1;
     arr2 = newArray(newlength);
     for (i=0; i<arr.length; i++)
        arr2[i] = arr[i];
     arr2[arr.length] = value;
     return arr2;
  }

function listFiles(dir1) {
          list=getFileList(dir1);
          var filelist=newArray;
        for (q=0; q<list.length; q++) {
        if (endsWith(list[q], ".tif") || endsWith(list[q], ".tiff") || endsWith(list[q], ".jpg") || endsWith(list[q], ".jpeg")|| endsWith(list[q], ".zip") || endsWith(list[q], ".TIFF") || endsWith(list[q], ".TIF") || endsWith(list[q], ".JPEG") || endsWith(list[q], ".JPG") || endsWith(list[q], ".ZIP") )
           filelist = append(filelist, dir1+list[q]);
     }
    return filelist;
  }

function savefiles(filelist) {
	var files=newArray;
	for (p=0; p<filelist.length; p++) {
	files0=filelist[p];
	ind1_=lastIndexOf(files0, "\\");
	ind2_=lengthOf(files0);
	files_=substring(files0, ind1_+1, ind2_);
	files=append(files, files_);
	}
	return files;
	
}
function ratio() {
for (l=0; l<n; l++){
		dl=getResult("axon length", l);
		da=getResult("disorganised area", l);
		dr=da/dl;
		setResult("disorganisation ratio", l, dr);
		}
	}
/* start actual macro */

dir1 = getDirectory("Choose Input Directory ");
dir2 = getDirectory("Choose Output Directory "); 
	count = 1;
	var filelist=newArray;
	var files=newArray;
	list=getFileList(dir1);
	items = list.length;
	filelist=listFiles(dir1);
	Array.sort(filelist);
	z =	lengthOf(filelist);
//	savefiles(filelist);
	files=savefiles(filelist);
	Array.print(filelist);
setBatchMode(true);
run("Input/Output...", "save_column");
k=0;
run("Set Measurements...", "area mean redirect=None decimal=4");
/*get image scaling data from user*/
dist_=getNumber("enter distance per pixel a.k.a. scaling factor:", 150);
unit_=getString("enter distance unit:", "µm");
notice = "converting: \n";
print(notice);

for (j=0; j<z; j+=2){
	open(filelist[j]);
//	print("opening image file: "+filelist[j]);
	imageTitle=getTitle(); //returns a string with the image title
	roiManager("Open", filelist[j+1]);
//	print("opening zip file: "+filelist[j+1]);
	n = roiManager("count");
	run("Set Scale...", "distance=&dist_ known=1 pixel=1 unit=&unit_");
	run("Select All");
	roiManager("multi-measure measure_all");
	selectWindow(imageTitle);
	close();
	roiManager("Reset");
/*Verfies that the Results table is open */
	if (! isOpen("Results")) {exit ("No Results table")}
/*	s=nResults-1; */
	

/*checks that there are actually results and the table is open */
	if (nResults() > 0 && isOpen("Results")) {
		tableF3();
		ratio();};
	selectWindow("Results");
	saveAs("Results", dir2+files[j]+"_"+"length_disorg"+"_results.txt");
	run("Close");
	currentfile = dir2+files[j]+ "\n";
	print(currentfile);
}
print("conversion done");
}