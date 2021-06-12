//Sydney Cason, last updated 11/2/2018
//open image
waitForUser("Open Image", "Drag image into FIJI pane to open");
rename("Axon");
selectWindow("Axon");
//deinterleave video
run("Deinterleave", "how=2");
//Max project & pseudocolor the MT channel
selectWindow("Axon #1");
run("Z Project...", "projection=[Max Intensity]");
run("Green Fire Blue");
waitForUser("ROI Set Saving", "Click OK when you are ready to save the ROI set");
//select all ROIs
roiArray = newArray("0");;
for (i = 0; i < roiManager("count"); i++) {
	roiArray = Array.concat(roiArray,i);
}
print(roiManager("count"));
//create file name
title = "Untitled";
Dialog.create("Save ROIs as");
Dialog.addString("Title:", title);
Dialog.show();
title = Dialog.getString();
//save ROI set file
roiManager("select", roiArray);
roiManager("Save", "/Users/scason/Desktop/October/" + title + "_ROIset.zip");
roiManager("Deselect");
//create kymographs for all ROIs in ch 1
for (i = 0; i < roiManager("count"); i++) {
	selectWindow("Axon #1");
	roiManager("Select", i);
	run("Multi Kymograph", "linewidth=5");
	selectWindow("Kymograph");
	saveAs("Tiff", "/Users/scason/Desktop/October/" + title + "_kymograph" + i+roiManager("count") + "_gfpLC3.tif");
}
roiManager("Deselect");
//create kymographs for all ROIs in ch 2
for (i = 0; i < roiManager("count"); i++) {
	selectWindow("Axon #2");
	roiManager("Select", i);
	run("Multi Kymograph", "linewidth=5");
	selectWindow("Kymograph");
	saveAs("Tiff", "/Users/scason/Desktop/October/" + title + "_kymograph" + i+roiManager("count") + "_HAP1.tif");
}
waitForUser("View Kymograph", "Take any notes needed, THEN click OK");
roiManager("select", roiArray);
roiManager("Delete");
run("Close All");   