function [squaredROIError,squaredROIRandomizedError] = calculateROIStability(ROIs,averageProjections)

    % field of view: 750 x 750 pixels ==> 425 × 425 μm
    % squared ROI:    53 x  53 pixels ==>  30 x  30 μm

    % Display
    fprintf('\n')
    disp('     Calculating cell ROI stability...')
    wb = waitbar(0,'Initializing...','Name','Calculating cell ROI stability...','CreateCancelBtn','setappdata(gcbf,''canceling'',1)');
    setappdata(wb,'canceling',0);

    iterations = 100;
    displayROIs = 50;
    squaredROIError = NaN(size(ROIs{1},1),4,2);
    squaredROIRandomizedError = NaN(size(ROIs{1},1),iterations,4,2);

    disp(['         Started at ',datestr(now,'HH'),'h ',datestr(now,'MM'),'m ',datestr(now,'SS'),'s...'])

    for n=1:size(ROIs{1},1)

        % Waitbar
            % Check for clicked Cancel button
            if getappdata(wb,'canceling')
                selection = questdlg('Do you want to stop this process?','Stop process','Yes','No','Yes');
                    switch selection
                        case 'Yes'
                            delete(gcf)
                            break
                        case 'No'
                            setappdata(wb,'canceling',0);
                    end
            end
            % Update waitbar and message
            waitbar(n/size(ROIs{1},1),wb,['cell ROI ',num2str(n),' out of ',num2str(size(ROIs{1},1))])
    
        % ROI
        squaredROI = poly2mask(ROIs{1}{n}(:,1),ROIs{1}{n}(:,2),size(averageProjections,1),size(averageProjections,2));
        s = regionprops(squaredROI,'centroid');
        if length(s)>1
            s = s(1);
            disp(['         WARNING: bad ROI (#',num2str(n),'), more than 1 ROIs identified as a single ROI.'])
        end
        s = round(s.Centroid);
            % Get Squared ROI
            x1 = s(2)-26;
            x2 = s(2)+26;
            y1 = s(1)-26;
            y2 = s(1)+26;
            if x1<=0
                x1 = 1;
                x2 = 53;
            end
            if x2>size(averageProjections,1)
                x1 = size(averageProjections,1)-52;
                x2 = size(averageProjections,1);
            end
            if y1<=0
                y1 = 1;
                y2 = 53;
            end
            if y2>size(averageProjections,2)
                y1 = size(averageProjections,2)-52;
                y2 = size(averageProjections,2);
            end
            map = averageProjections(:,:,1);
            referenceSquaredAPROI = map(x1:x2,y1:y2);
                % ROI post-processing
                AP = referenceSquaredAPROI;
                for l=1:size(AP,1)
                    AP(l,:) = AP(l,:) - mean(AP(l,:));
                end
                X = imresize(AP,[59 59]);
                X(4:56,4:56) = AP;
                SE = strel("disk",2);
                X = conv2(X,SE.Neighborhood,'same');
                AP = X(4:56,4:56);
                AP = imresize(AP,[500 500]);
                AP = mat2gray(AP,[prctile(AP,5,'all') prctile(AP,95,'all')]);
                referenceSquaredAPROI = AP;
                clear('AP','X','SE')
            clear('map')
        clear('squaredROI','s','x1','x2','y1','y2')
    
        for d=2:length(ROIs)
    
            % Squared ROI
            squaredROI = poly2mask(ROIs{d}{n}(:,1),ROIs{d}{n}(:,2),750,750);
            s = regionprops(squaredROI,'centroid');
            if length(s)>1
                s = s(1);
            end
            s = round(s.Centroid);
                % Get Squared ROI
                x1 = s(2)-26;
                x2 = s(2)+26;
                y1 = s(1)-26;
                y2 = s(1)+26;
                if x1<=0
                    x1 = 1;
                    x2 = 53;
                end
                if x2>750
                    x1 = 698;
                    x2 = 750;
                end
                if y1<=0
                    y1 = 1;
                    y2 = 53;
                end
                if y2>750
                    y1 = 698;
                    y2 = 750;
                end
                map = averageProjections(:,:,d);
                testSquaredAPROI = map(x1:x2,y1:y2);
                    % ROI post-processing
                    AP = testSquaredAPROI;
                    for l=1:size(AP,1)
                        AP(l,:) = AP(l,:) - mean(AP(l,:));
                    end
                    X = imresize(AP,[59 59]);
                    X(4:56,4:56) = AP;
                    SE = strel("disk",2);
                    X = conv2(X,SE.Neighborhood,'same');
                    AP = X(4:56,4:56);
                    AP = imresize(AP,[500 500]);
                    AP = mat2gray(AP,[prctile(AP,5,'all') prctile(AP,95,'all')]);
                    testSquaredAPROI = AP;
                    clear('AP','X','SE')
                % True Error
                squaredROIError(n,d-1,1) = ssim(testSquaredAPROI,referenceSquaredAPROI);
                squaredROIError(n,d-1,2) = corr2(testSquaredAPROI,referenceSquaredAPROI);
                clear('map','testSquaredAPROI')
            clear('squaredROI','s','x1','x2','y1','y2')
    
            % Error Random Distribution
            for k=1:iterations
                % Random Squared ROI
                randIdx = randi(size(ROIs{1},1));
                squaredROI = poly2mask(ROIs{d}{randIdx}(:,1),ROIs{d}{randIdx}(:,2),750,750);
                s = regionprops(squaredROI,'centroid');
                if length(s)>1
                    s = s(1);
                end
                s = round(s.Centroid);
                    % Get Squared ROI
                    x1 = s(2)-26;
                    x2 = s(2)+26;
                    y1 = s(1)-26;
                    y2 = s(1)+26;
                    if x1<=0
                        x1 = 1;
                        x2 = 53;
                    end
                    if x2>750
                        x1 = 698;
                        x2 = 750;
                    end
                    if y1<=0
                        y1 = 1;
                        y2 = 53;
                    end
                    if y2>750
                        y1 = 698;
                        y2 = 750;
                    end
                    map = averageProjections(:,:,d);
                    testSquaredAPROI = map(x1:x2,y1:y2);
                        % ROI post-processing
                        AP = testSquaredAPROI;
                        for l=1:size(AP,1)
                            AP(l,:) = AP(l,:) - mean(AP(l,:));
                        end
                        X = imresize(AP,[59 59]);
                        X(4:56,4:56) = AP;
                        SE = strel("disk",2);
                        X = conv2(X,SE.Neighborhood,'same');
                        AP = X(4:56,4:56);
                        AP = imresize(AP,[500 500]);
                        AP = mat2gray(AP,[prctile(AP,5,'all') prctile(AP,95,'all')]);
                        testSquaredAPROI = AP;
                        clear('AP','X','SE')
                    % Random Error
                    squaredROIRandomizedError(n,k,d-1,1) = ssim(testSquaredAPROI,referenceSquaredAPROI);
                    squaredROIRandomizedError(n,k,d-1,2) = corr2(testSquaredAPROI,referenceSquaredAPROI);
                    clear('map','testSquaredAPROI')
                clear('randIdx','squaredROI','s','x1','x2','y1','y2')
            end
    
        end

        if rem(n,displayROIs)==0
            disp(['             ROI # ',num2str(n),' complete.'])
        end
    
    end
    delete(wb)

    disp(['         Finished at ',datestr(now,'HH'),'h ',datestr(now,'MM'),'m ',datestr(now,'SS'),'s.'])
    fprintf('\n')

