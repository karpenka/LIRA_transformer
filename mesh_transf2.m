import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('C:\JOB\comsol\test');

model.component.create('comp1', true);

model.component('comp1').geom.create('geom1', 3);

model.component('comp1').mesh.create('mesh1');

model.component('comp1').geom('geom1').create('imp1', 'Import');
model.component('comp1').geom('geom1').feature('imp1').set('filename', 'C:\JOB\comsol\test\oct.stl');

model.component.create('mcomp1', 'MeshComponent');

model.geom.create('mgeom1', 3);

model.mesh.create('mpart1', 'mgeom1');

model.component('comp1').geom('geom1').feature('imp1').set('mesh', 'mpart1');

model.mesh('mpart1').create('imp1', 'Import');
model.mesh('mpart1').feature('imp1').set('filename', 'C:\JOB\comsol\test\oct.stl');

model.component('comp1').geom('geom1').feature('imp1').set('meshfilename', '');

model.mesh('mpart1').run;

model.component('comp1').geom('geom1').feature('imp1').importData;
model.component('comp1').geom('geom1').run;

model.component('comp1').mesh('mesh1').autoMeshSize(9);
model.component('comp1').mesh('mesh1').run;
model.component('comp1').mesh('mesh1').export.set('type', 'stlbin');
model.component('comp1').mesh('mesh1').export.set('filename', 'C:\JOB\comsol\test\mesh_transf4.stl');
model.component('comp1').mesh('mesh1').export('C:\JOB\comsol\test\mesh_transf4.stl');
