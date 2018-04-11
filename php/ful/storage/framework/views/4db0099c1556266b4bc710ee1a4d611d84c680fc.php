<?php $__env->startSection('content'); ?>
    <div class="row">
        <?php if(sizeof($news)>=2): ?>
            <?php for($i=0;$i<2;$i++): ?>
                <div class="col-md-6">
	            <h2><?php echo e($news[$i]->title); ?></h2>
	            <p class="input-sm"><?php echo e($news[$i]->updated_at); ?></p>
	            <p class="panel-title"><?php echo e($news[$i]->summary); ?></p>
	            <p><a class="btn btn-secondary" href="news/<?php echo e($news[$i]->id); ?>" role="button">Detalles &raquo;</a></p>
                </div>
            <?php endfor; ?>
        <?php endif; ?>
    </div>
    <div class="row">
        <?php if(sizeof($news)>=4): ?>
            <?php for($i=2;$i<4;$i++): ?>
                <div class="col-md-6">
	            <h2><?php echo e($news[$i]->title); ?></h2>
	            <p class="input-sm"><?php echo e($news[$i]->updated_at); ?></p>
	            <p><?php echo e($news[$i]->summary); ?></p>
	            <p><a class="btn btn-secondary" href="news/<?php echo e($news[$i]->id); ?>" role="button">Detalles &raquo;</a></p>
                </div>
            <?php endfor; ?>
        <?php endif; ?>
    </div>
    <?php for($i=4;$i<min(14,sizeof($news));$i++): ?>
        <div class="row">
            <div class="col-md-0">
                <h2><?php echo e($news[$i]->title); ?></h2>
	        <p class="input-sm"><?php echo e($news[$i]->updated_at); ?></p>
                <p><?php echo e($news[$i]->summary); ?></p>
                <p><a class="btn btn-secondary" href="news/<?php echo e($news[$i]->id); ?>" role="button">Detalles &raquo;</a></p>
            </div>
        </div>
    <?php endfor; ?>
<?php $__env->stopSection(); ?>

<?php echo $__env->make('layout', array_except(get_defined_vars(), array('__data', '__path')))->render(); ?>