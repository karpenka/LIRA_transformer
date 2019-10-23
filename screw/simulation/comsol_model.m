width_min = 0.03; width_max = 0.03; width_step = 0.01;
height_min = 0.15; height_max = 0.15; height_step = 0.03;
length_num = 1:3:40;
length_str = sprintfc('%d',length_num);
ppath = '/home/nerde/JOB/github/Octagon-guide/screw/simulation/stl/';

for w = width_min:width_step:width_max
    for h = height_min:height_step:height_max
        for len = 1:length(length_num)
            filename = ['l_' length_str{len} '_w_' num2str(w*100) '_h_' num2str(h*100) '.stl'];
            import com.comsol.model.*
            import com.comsol.model.util.*

            model = ModelUtil.create('Model');

            model.component.create('comp1', true);

            model.component('comp1').geom.create('geom1', 3);

            model.component('comp1').mesh.create('mesh1');

            model.component('comp1').geom('geom1').create('blk1', 'Block');
            model.component('comp1').geom('geom1').feature('blk1').set('size', [w 1 h]);
            model.component('comp1').geom('geom1').create('ext1', 'Extrude');
            model.component('comp1').geom('geom1').feature('ext1').setIndex('distance', length_str{len}, 0);
            model.component('comp1').geom('geom1').feature('ext1').setIndex('twist', '90', 0);
            model.component('comp1').geom('geom1').feature('ext1').selection('inputface').set('blk1(1)', 3);
            model.component('comp1').geom('geom1').create('del1', 'Delete');
            model.component('comp1').geom('geom1').feature('del1').selection('input').set('ext1(1)', 5);
            model.component('comp1').geom('geom1').create('del2', 'Delete');
            model.component('comp1').geom('geom1').feature('del2').selection('input').set('del1(1)', 10);
            model.component('comp1').geom('geom1').create('del3', 'Delete');
            model.component('comp1').geom('geom1').feature('del3').selection('input').set('del2(1)', 7);
            model.component('comp1').geom('geom1').create('del4', 'Delete');
            model.component('comp1').geom('geom1').feature('del4').selection('input').set('del3(1)', 8);
            model.component('comp1').geom('geom1').create('del5', 'Delete');
            model.component('comp1').geom('geom1').feature('del5').selection('input').set('del4(1)', 6);
            model.component('comp1').geom('geom1').create('del6', 'Delete');
            model.component('comp1').geom('geom1').feature('del6').selection('input').set('del5(1)', 2);
            model.component('comp1').geom('geom1').create('del7', 'Delete');
            model.component('comp1').geom('geom1').feature('del7').selection('input').set('del6(1)', 4);
            model.component('comp1').geom('geom1').run;
            model.component('comp1').mesh('mesh1').autoMeshSize(1);
            model.component('comp1').mesh('mesh1').run;
            model.component('comp1').mesh('mesh1').export.set('filename', [ppath filename]);
            model.component('comp1').mesh('mesh1').export([ppath filename]);
            % Finished running method twist
            out = model;
        end
    end
end


