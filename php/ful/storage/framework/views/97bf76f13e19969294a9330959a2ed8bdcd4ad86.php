<?php $__env->startSection('content'); ?>
    Temporada: 
    <?php $__currentLoopData = $periods; $__env->addLoop($__currentLoopData); foreach($__currentLoopData as $period): $__env->incrementLoopIndices(); $loop = $__env->getLastLoop(); ?>
        <a href="?temp=<?php echo e($period->period); ?>"><?php echo e($period->period); ?></a>
    <?php endforeach; $__env->popLoop(); $loop = $__env->getLastLoop(); ?>
    <hr>
    <?php $__currentLoopData = $fixture; $__env->addLoop($__currentLoopData); foreach($__currentLoopData as $d): $__env->incrementLoopIndices(); $loop = $__env->getLastLoop(); ?>
        <h4 style="text-align:center">Fecha <?php echo e($d[0]->day+1); ?></h4>
        <table class="table table-condensed table-striped" border="2">
            <tbody>
                <?php $__currentLoopData = $d; $__env->addLoop($__currentLoopData); foreach($__currentLoopData as $e): $__env->incrementLoopIndices(); $loop = $__env->getLastLoop(); ?>
                    <tr>
                        <th class="th-l ar"><?php echo e($e->team1->name); ?></th>
                        <th class="th-s ac"><?php echo e($e->score1); ?></th>
                        <th class="th-s ac"><?php echo e($e->score2); ?></th>
                        <th class="th-l al"><?php echo e($e->team2->name); ?></th>
                    </tr>
                <?php endforeach; $__env->popLoop(); $loop = $__env->getLastLoop(); ?>
            </tbody>
        </table>
    <?php endforeach; $__env->popLoop(); $loop = $__env->getLastLoop(); ?>
<?php $__env->stopSection(); ?>
<style>
 .ar {text-align:right;}
 .ac {text-align:center;}
 .th-s {width:40px;}
 .th-l {width:120px;}
</style>

<?php echo $__env->make('layout', array_except(get_defined_vars(), array('__data', '__path')))->render(); ?>