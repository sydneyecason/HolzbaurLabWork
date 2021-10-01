//Sydney Cason, last updated 10/1/2021
Please adjust for your data. Also, if you would like to ammend any inefficiencies, feel free. I am available for questions or comments via email sydney.e.cason@gmail.com
//open image
waitForUser("Open Image", "Drag image into FIJI pane to open");
rename("Axon");
selectWindow("Axon");
//deinterleave video; adjust number following "how=" with number of channels
run("Deinterleave", "how=2");
//Max project & pseudocolor the channel that will be used to trace the axon
selectWindow("Axon #1");
run("Z Project...", "projection=[Max Intensity]");
run("Green Fire Blue");
waitForUser("ROI Set Saving", "Trace the axon then click OK when you are ready to save the ROI(s)");
//select all ROIs
roiArray = newArray("0");;
for (i = 0; i < roiManager("count"); i++) {
	roiArray = Array.concat(roiArray,i);
}
//create file name; the user will need to insert the name of the video
title = "Untitled";
Dialog.create("Save ROI and kymographs as");
Dialog.addString("Title:", title);
Dialog.show();
title = Dialog.getString();
//adjust all of the below "/SaveLocation/" with the folder were you would like to save your ROI(s) and kymographs. If you have more than 2 channels, you must duplicate the "create kymographs for all ROIs" for-loops and adjust for the additional channels.
//save ROI set file
roiManager("select", roiArray);
roiManager("Save", "/SaveLocation/" + title + "_ROIset.zip");
roiManager("Deselect");
//create kymographs for all ROIs in ch 1
for (i = 0; i < roiManager("count"); i++) {
	selectWindow("Axon #1");
	roiManager("Select", i);
	run("Multi Kymograph", "linewidth=5");
	selectWindow("Kymograph");
	saveAs("Tiff", "/SaveLocation/" + title + "_kymograph" + i+roiManager("count") + "_ch1.tif");
}
roiManager("Deselect");
//create kymographs for all ROIs in ch 2
for (i = 0; i < roiManager("count"); i++) {
	selectWindow("Axon #2");
	roiManager("Select", i);
	run("Multi Kymograph", "linewidth=5");
	selectWindow("Kymograph");
	saveAs("Tiff", "/SaveLocation/" + title + "_kymograph" + i+roiManager("count") + "_ch2.tif");
}
waitForUser("View Kymograph", "Take any notes needed, THEN click OK");
roiManager("select", roiArray);
roiManager("Delete");
run("Close All");   
