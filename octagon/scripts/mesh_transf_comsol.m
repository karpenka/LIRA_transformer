function mesh_transf_comsol(path)
import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('C:\JOB\comsol\test');

model.component.create('comp1', true);

model.component('comp1').geom.create('geom1', 3);

model.component('comp1').mesh.create('mesh1');

model.component('comp1').geom('geom1').create('imp1', 'Import');
model.component('comp1').geom('geom1').feature('imp1').set('filename', [path '/oct.stl']);

model.component.create('mcomp1', 'MeshComponent');

model.geom.create('mgeom1', 3);

model.mesh.create('mpart1', 'mgeom1');

model.component('comp1').geom('geom1').feature('imp1').set('mesh', 'mpart1');

model.mesh('mpart1').create('imp1', 'Import');
model.mesh('mpart1').feature('imp1').set('filename', [path '/oct.stl']);

model.component('comp1').geom('geom1').feature('imp1').set('meshfilename', '');

model.mesh('mpart1').run;

model.component('comp1').geom('geom1').feature('imp1').importData;
model.component('comp1').geom('geom1').run;

model.component('comp1').mesh('mesh1').autoMeshSize(4);
model.component('comp1').mesh('mesh1').run;
model.component('comp1').mesh('mesh1').export.set('type', 'stlbin');
model.component('comp1').mesh('mesh1').export.set('filename', [path '/oct_comsol.stl']);
model.component('comp1').mesh('mesh1').export([path '/oct_comsol.stl']);
end